// attendance.js - Version corrigée avec gestion des événements
document.addEventListener('DOMContentLoaded', function() {
  const attendanceForm = document.getElementById('attendanceForm');
  const classSelect = document.getElementById('class');
  const subjectSelect = document.getElementById('subject');
  const timeSlotSelect = document.getElementById('timeSlot');
  const studentsList = document.getElementById('studentsList');
  const resetBtn = document.getElementById('resetBtn');
  const submitBtn = document.getElementById('submitBtn');
  
  let students = [];
  let studentStatuses = new Map(); // Map pour stocker les statuts des élèves
  let isSubmitted = false;
  let currentEnseignements = [];
  
  // Configuration du toast
  const toast = {
    element: document.getElementById('toast'),
    title: document.querySelector('.toast-title'),
    body: document.querySelector('.toast-body'),
    close: document.querySelector('.toast-close'),
    
    show: function(title, message, type = 'success') {
      this.title.textContent = title;
      this.body.textContent = message;
      
      this.element.className = 'toast show';
      
      if (type === 'error') {
        this.element.style.borderLeftColor = 'var(--danger)';
        this.title.previousElementSibling.style.color = 'var(--danger)';
      } else {
        this.element.style.borderLeftColor = 'var(--primary)';
        this.title.previousElementSibling.style.color = 'var(--primary)';
      }
      
      setTimeout(() => {
        this.hide();
      }, 5000);
    },
    
    hide: function() {
      this.element.classList.remove('show');
    }
  };

  // Fonction pour faire les requêtes API
  async function apiRequest(url, options = {}) {
    try {
      const response = await fetch(url, {
        ...options,
        headers: {
          'Content-Type': 'application/json',
          'X-CSRFToken': getCsrfToken(),
          ...options.headers
        }
      });
      
      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
      }
      
      return await response.json();
    } catch (error) {
      console.error('Erreur API:', error);
      throw error;
    }
  }

  // Récupérer le token CSRF
  function getCsrfToken() {
    return document.querySelector('[name=csrfmiddlewaretoken]')?.value || 
           document.querySelector('meta[name="csrf-token"]')?.getAttribute('content') || '';
  }

  // Charger les enseignements de l'enseignant
  async function loadTeacherData() {
    try {
      const data = await apiRequest('/api/teacher/dashboard/');
      
      if (data.success) {
        currentEnseignements = data.enseignements;
        populateClassSelect();
      } else {
        throw new Error(data.error || 'Erreur lors du chargement des données');
      }
    } catch (error) {
      console.error('Erreur lors du chargement des enseignements:', error);
      toast.show('Erreur', 'Impossible de charger vos classes', 'error');
    }
  }

  // Remplir la liste déroulante des classes
  function populateClassSelect() {
    if (!classSelect) return;
    
    // Vider les options existantes sauf la première
    while (classSelect.children.length > 1) {
      classSelect.removeChild(classSelect.lastChild);
    }
    
    // Grouper par classe pour éviter les doublons
    const classes = [...new Set(currentEnseignements.map(ens => ens.classe))];
    
    classes.forEach(classe => {
      const option = document.createElement('option');
      option.value = classe;
      option.textContent = classe;
      classSelect.appendChild(option);
    });
  }

  // Remplir la liste des matières en fonction de la classe sélectionnée
  function populateSubjectSelect(selectedClass) {
    if (!subjectSelect || !selectedClass) return;
    
    // Vider les options existantes sauf la première
    while (subjectSelect.children.length > 1) {
      subjectSelect.removeChild(subjectSelect.lastChild);
    }
    
    // Trouver les matières pour cette classe
    const matieres = currentEnseignements
      .filter(ens => ens.classe === selectedClass)
      .map(ens => ens.matiere);
    
    matieres.forEach(matiere => {
      const option = document.createElement('option');
      option.value = matiere;
      option.textContent = matiere;
      subjectSelect.appendChild(option);
    });
    
    // Réinitialiser la sélection
    subjectSelect.value = '';
  }

  // Charger les élèves pour une classe
  async function loadStudents(className) {
    if (!className) return;
    
    try {
      // Trouver l'enseignement correspondant pour récupérer l'ID de la classe
      const enseignement = currentEnseignements.find(ens => ens.classe === className);
      if (!enseignement) {
        throw new Error('Classe non trouvée dans vos enseignements');
      }
      
      const data = await apiRequest(`/api/teacher/classes/students/?enseignement_id=${enseignement.id}`);
      
      if (data.success) {
        students = data.eleves;
        studentStatuses.clear();
        
        // Initialiser tous les élèves comme présents
        students.forEach(student => {
          studentStatuses.set(student.id, {
            statut: 'present',
            remarque: ''
          });
        });
        
        renderStudentsList();
      } else {
        throw new Error(data.error || 'Erreur lors du chargement des élèves');
      }
    } catch (error) {
      console.error('Erreur lors du chargement des élèves:', error);
      toast.show('Erreur', error.message, 'error');
      
      // Afficher un message d'erreur dans la liste
      studentsList.innerHTML = `
        <div class="placeholder-message">
          <p class="text-danger">Erreur lors du chargement des élèves: ${error.message}</p>
        </div>
      `;
    }
  }

  // Afficher la liste des élèves
  function renderStudentsList() {
    if (!studentsList || !students.length) {
      studentsList.innerHTML = `
        <div class="placeholder-message">
          <p>Aucun élève dans cette classe</p>
        </div>
      `;
      return;
    }

    let html = `
      <div class="students-header">
        <h3>Liste des élèves (${students.length})</h3>
        ${!isSubmitted ? `
          <div class="bulk-actions">
            <button type="button" class="btn btn-sm btn-outline-secondary" id="markAllPresentBtn">
              Tous présents
            </button>
            <button type="button" class="btn btn-sm btn-outline-warning" id="markAllAbsentBtn">
              Tous absents
            </button>
          </div>
        ` : ''}
      </div>
      <div class="students-table">
        <table class="table">
          <thead>
            <tr>
              <th>Nom</th>
              <th>Prénom</th>
              <th>Statut</th>
              <th>Remarques</th>
            </tr>
          </thead>
          <tbody>
    `;

    students.forEach(student => {
      const status = studentStatuses.get(student.id);
      const isPresent = status.statut === 'present';
      const isAbsent = status.statut === 'absent';
      const isLate = status.statut === 'retard';

      html += `
        <tr class="student-row ${status.statut}" data-student-id="${student.id}">
          <td class="student-name">${student.nom}</td>
          <td class="student-firstname">${student.prenom}</td>
          <td class="status-controls">
            ${!isSubmitted ? `
              <div class="status-buttons">
                <button type="button" 
                        class="status-btn present ${isPresent ? 'active' : ''}" 
                        data-student-id="${student.id}"
                        data-status="present"
                        title="Présent">
                  <i class="fa-solid fa-check"></i>
                </button>
                <button type="button" 
                        class="status-btn absent ${isAbsent ? 'active' : ''}" 
                        data-student-id="${student.id}"
                        data-status="absent"
                        title="Absent">
                  <i class="fa-solid fa-times"></i>
                </button>
                <button type="button" 
                        class="status-btn late ${isLate ? 'active' : ''}" 
                        data-student-id="${student.id}"
                        data-status="retard"
                        title="Retard">
                  <i class="fa-solid fa-clock"></i>
                </button>
              </div>
            ` : `
              <span class="status-label ${status.statut}">
                ${getStatusLabel(status.statut)}
              </span>
            `}
          </td>
          <td class="remarks">
            ${!isSubmitted ? `
              <input type="text" 
                     class="form-control form-control-sm remark-input" 
                     placeholder="Remarques..."
                     value="${status.remarque}"
                     data-student-id="${student.id}">
            ` : `
              <span class="remark-text">${status.remarque || '-'}</span>
            `}
          </td>
        </tr>
      `;
    });

    html += `
          </tbody>
        </table>
      </div>
    `;

    studentsList.innerHTML = html;
    
    // Ajouter les event listeners pour les nouveaux éléments
    addEventListenersToStudentsList();
    updateSubmitButton();
  }

  // Ajouter les event listeners aux éléments de la liste des élèves
  function addEventListenersToStudentsList() {
    // Event listeners pour les boutons de statut
    const statusButtons = studentsList.querySelectorAll('.status-btn');
    statusButtons.forEach(button => {
      button.addEventListener('click', function(e) {
        e.preventDefault();
        const studentId = parseInt(this.dataset.studentId);
        const status = this.dataset.status;
        updateStudentStatus(studentId, status);
      });
    });

    // Event listeners pour les champs de remarques
    const remarkInputs = studentsList.querySelectorAll('.remark-input');
    remarkInputs.forEach(input => {
      input.addEventListener('change', function() {
        const studentId = parseInt(this.dataset.studentId);
        updateStudentRemarks(studentId, this.value);
      });
    });

    // Event listeners pour les boutons en masse
    const markAllPresentBtn = document.getElementById('markAllPresentBtn');
    const markAllAbsentBtn = document.getElementById('markAllAbsentBtn');
    
    if (markAllPresentBtn) {
      markAllPresentBtn.addEventListener('click', markAllPresent);
    }
    
    if (markAllAbsentBtn) {
      markAllAbsentBtn.addEventListener('click', markAllAbsent);
    }
  }

  // Mettre à jour le statut d'un élève
  function updateStudentStatus(studentId, newStatus) {
    console.log('Mise à jour du statut:', studentId, newStatus); // Debug
    
    const currentStatus = studentStatuses.get(studentId);
    studentStatuses.set(studentId, {
      ...currentStatus,
      statut: newStatus
    });
    
    // Mettre à jour l'affichage de cette ligne
    const row = document.querySelector(`tr[data-student-id="${studentId}"]`);
    if (row) {
      row.className = `student-row ${newStatus}`;
      
      // Mettre à jour les boutons actifs
      const buttons = row.querySelectorAll('.status-btn');
      buttons.forEach(btn => {
        btn.classList.remove('active');
        if (btn.dataset.status === newStatus) {
          btn.classList.add('active');
        }
      });
    }
    
    updateSubmitButton();
  }

  // Mettre à jour les remarques d'un élève
  function updateStudentRemarks(studentId, remarks) {
    console.log('Mise à jour des remarques:', studentId, remarks); // Debug
    
    const currentStatus = studentStatuses.get(studentId);
    studentStatuses.set(studentId, {
      ...currentStatus,
      remarque: remarks
    });
  }

  // Obtenir le libellé du statut
  function getStatusLabel(status) {
    const labels = {
      'present': 'Présent',
      'absent': 'Absent',
      'retard': 'Retard'
    };
    return labels[status] || status;
  }

  // Marquer tous les élèves comme présents
  function markAllPresent() {
    students.forEach(student => {
      studentStatuses.set(student.id, {
        ...studentStatuses.get(student.id),
        statut: 'present'
      });
    });
    renderStudentsList();
  }

  // Marquer tous les élèves comme absents
  function markAllAbsent() {
    students.forEach(student => {
      studentStatuses.set(student.id, {
        ...studentStatuses.get(student.id),
        statut: 'absent'
      });
    });
    renderStudentsList();
  }

  // Mettre à jour l'état du bouton de soumission
  function updateSubmitButton() {
    if (!submitBtn) return;
    
    const hasStudents = students.length > 0;
    const hasFormData = classSelect.value && subjectSelect.value && timeSlotSelect.value;
    
    submitBtn.disabled = !hasStudents || !hasFormData || isSubmitted;
    
    if (isSubmitted) {
      submitBtn.innerHTML = '<i class="fa-solid fa-check"></i> Appel enregistré';
      submitBtn.classList.remove('btn-primary');
      submitBtn.classList.add('btn-success');
    }
  }

  // Enregistrer l'appel
  async function saveAttendance() {
    try {
      submitBtn.disabled = true;
      submitBtn.innerHTML = '<i class="fa-solid fa-spinner fa-spin"></i> Enregistrement...';
      
      // Récupérer l'enseignement correspondant
      const selectedClass = classSelect.value;
      const selectedSubject = subjectSelect.value;
      const enseignement = currentEnseignements.find(ens => 
        ens.classe === selectedClass && ens.matiere === selectedSubject
      );
      
      if (!enseignement) {
        throw new Error('Enseignement non trouvé');
      }
      
      // Préparer les données de présence
      const presences = students.map(student => {
        const status = studentStatuses.get(student.id);
        return {
          eleve_id: student.id,
          statut: status.statut,
          remarque: status.remarque || ''
        };
      });
      
      // Extraire les heures du créneau sélectionné
      const timeSlot = timeSlotSelect.value;
      const [heureDebut, heureFin] = timeSlot.split('-');
      
      // Préparer les données à envoyer
      const data = {
        enseignement_id: enseignement.id,
        date: new Date().toISOString().split('T')[0], // Date d'aujourd'hui
        heure_debut: heureDebut.replace('h', ':00'),
        heure_fin: heureFin.replace('h', ':00'),
        presences: presences
      };
      
      console.log('Données à envoyer:', data); // Debug
      
      // Envoyer les données
      const response = await apiRequest('/api/teacher/attendance/save/', {
        method: 'POST',
        body: JSON.stringify(data)
      });
      
      if (response.success) {
        isSubmitted = true;
        toast.show('Succès', response.message, 'success');
        renderStudentsList(); // Re-render pour désactiver les contrôles
        updateSubmitButton();
        
        // Désactiver le formulaire
        classSelect.disabled = true;
        subjectSelect.disabled = true;
        timeSlotSelect.disabled = true;
        
      } else {
        throw new Error(response.error || 'Erreur lors de l\'enregistrement');
      }
      
    } catch (error) {
      console.error('Erreur lors de l\'enregistrement:', error);
      toast.show('Erreur', error.message, 'error');
      
      // Restaurer le bouton
      submitBtn.disabled = false;
      submitBtn.innerHTML = '<i class="fa-solid fa-save"></i> Enregistrer l\'appel';
    }
  }

  // Réinitialiser le formulaire
  function resetForm() {
    if (isSubmitted) {
      // Si l'appel a été enregistré, recharger la page
      if (confirm('Voulez-vous recommencer un nouvel appel ?')) {
        window.location.reload();
      }
      return;
    }
    
    // Réinitialiser les sélections
    classSelect.value = '';
    subjectSelect.value = '';
    timeSlotSelect.value = '';
    
    // Vider la liste des étudiants
    students = [];
    studentStatuses.clear();
    
    // Réinitialiser l'affichage
    studentsList.innerHTML = `
      <div class="placeholder-message">
        <p><i class="fa-solid fa-users"></i><br>
        Veuillez sélectionner une classe pour afficher la liste des élèves</p>
      </div>
    `;
    
    // Réactiver les champs
    classSelect.disabled = false;
    subjectSelect.disabled = false;
    timeSlotSelect.disabled = false;
    
    // Remettre les options des matières
    while (subjectSelect.children.length > 1) {
      subjectSelect.removeChild(subjectSelect.lastChild);
    }
    
    updateSubmitButton();
  }

  // Event Listeners principaux
  if (classSelect) {
    classSelect.addEventListener('change', function() {
      const selectedClass = this.value;
      if (selectedClass) {
        populateSubjectSelect(selectedClass);
        loadStudents(selectedClass);
      } else {
        students = [];
        studentStatuses.clear();
        renderStudentsList();
      }
    });
  }

  if (subjectSelect) {
    subjectSelect.addEventListener('change', updateSubmitButton);
  }

  if (timeSlotSelect) {
    timeSlotSelect.addEventListener('change', updateSubmitButton);
  }

  if (attendanceForm) {
    attendanceForm.addEventListener('submit', function(e) {
      e.preventDefault();
      if (!isSubmitted) {
        saveAttendance();
      }
    });
  }

  if (resetBtn) {
    resetBtn.addEventListener('click', function(e) {
      e.preventDefault();
      resetForm();
    });
  }

  // Fermeture du toast
  if (toast.close) {
    toast.close.addEventListener('click', () => {
      toast.hide();
    });
  }

  // Initialisation
  loadTeacherData();
});