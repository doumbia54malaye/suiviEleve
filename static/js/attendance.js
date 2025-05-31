
document.addEventListener('DOMContentLoaded', function() {
  // Éléments du DOM
  const attendanceForm = document.getElementById('attendanceForm');
  const classSelect = document.getElementById('class');
  const subjectSelect = document.getElementById('subject');
  const timeSlotSelect = document.getElementById('timeSlot');
  const studentsList = document.getElementById('studentsList');
  const resetBtn = document.getElementById('resetBtn');
  const submitBtn = document.getElementById('submitBtn');
  
  // Variables d'état
  let students = [];
  let absentStudents = new Set();
  let isSubmitted = false;
  
  // Configuration du toast
  const toast = {
    element: document.getElementById('toast'),
    title: document.querySelector('.toast-title'),
    body: document.querySelector('.toast-body'),
    close: document.querySelector('.toast-close'),
    
    show: function(title, message, type = 'success') {
      this.title.textContent = title;
      this.body.textContent = message;
      
      // Réinitialiser les classes
      this.element.className = 'toast show';
      
      // Ajouter la classe selon le type
      if (type === 'error') {
        this.element.style.borderLeftColor = 'var(--danger)';
        this.title.previousElementSibling.style.color = 'var(--danger)';
      } else {
        this.element.style.borderLeftColor = 'var(--primary)';
        this.title.previousElementSibling.style.color = 'var(--primary)';
      }
      
      // Masquer automatiquement après 5 secondes
      setTimeout(() => {
        this.hide();
      }, 5000);
    },
    
    hide: function() {
      this.element.classList.remove('show');
    }
  };
  
  // Vérifier si des paramètres sont passés dans l'URL
  function checkQueryParams() {
    const params = new URLSearchParams(window.location.search);
    const classParam = params.get('class');
    const timeParam = params.get('time');
    
    if (classParam) {
      // Trouver une option correspondante ou similaire
      const options = Array.from(classSelect.options);
      const option = options.find(opt => opt.value.replace(/\s+/g, '') === classParam);
      
      if (option) {
        classSelect.value = option.value;
        loadStudents(option.value);
      }
    }
    
    if (timeParam && timeSlotSelect) {
      const options = Array.from(timeSlotSelect.options);
      const option = options.find(opt => opt.value === timeParam);
      
      if (option) {
        timeSlotSelect.value = option.value;
      }
    }
  }
  
  // Générer des élèves fictifs pour une classe
  function generateMockStudents(className) {
    const count = 10 + Math.floor(Math.random() * 15); // Entre 10 et 25 élèves
    return Array.from({ length: count }, (_, i) => ({
      id: `student-${className.replace(/\s+/g, '')}-${i}`,
      firstName: `Prénom ${i + 1}`,
      lastName: `Nom ${i + 1}`
    }));
  }
  
  // Charger les élèves pour une classe
  function loadStudents(className) {
    if (!className) return;
    
    // Réinitialiser
    absentStudents.clear();
    isSubmitted = false;
    
    // Générer des élèves fictifs
    students = generateMockStudents(className);
    
    // Mettre à jour l'interface
    renderStudentsList();
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
        <h3>Liste des élèves</h3>
      </div>
      <table>
        <thead>
          <tr>
            <th class="w-50">Absent</th>
            <th>Nom</th>
            <th>Prénom</th>
            <th class="text-right">Action</th>
          </tr>
        </thead>
        <tbody>
    `;
    
    students.forEach(student => {
      const isAbsent = absentStudents.has(student.id);
      
      html += `
        <tr>
          <td>
            ${isSubmitted ? 
              `<input type="checkbox" ${isAbsent ? 'checked' : ''} disabled>` :
              `<div class="checkbox-container">
                <input type="checkbox" id="${student.id}" ${isAbsent ? 'checked' : ''} 
                  onchange="toggleAbsence('${student.id}')">
                <span class="checkmark"></span>
              </div>`
            }
          </td>
          <td>${student.lastName}</td>
          <td>${student.firstName}</td>
          <td class="text-right">
            ${isSubmitted && isAbsent ? 
              `<span class="text-danger" style="font-size: 0.75rem;">SMS envoyé aux parents</span>` : 
              ''}
          </td>
        </tr>
      `;
    });
    
    html += `
        </tbody>
      </table>
    `;
    
    studentsList.innerHTML = html;
    
    // Ajouter les gestionnaires d'événements pour les checkboxes
    if (!isSubmitted) {
      const checkboxes = studentsList.querySelectorAll('input[type="checkbox"]');
      checkboxes.forEach(checkbox => {
        checkbox.addEventListener('change', function() {
          toggleAbsence(this.id);
        });
      });
    }
  }
  
  // Marquer/démarquer un élève comme absent
  function toggleAbsence(studentId) {
    if (absentStudents.has(studentId)) {
      absentStudents.delete(studentId);
    } else {
      absentStudents.add(studentId);
    }
  }
  
  // Gérer la soumission du formulaire
  function handleFormSubmit(event) {
    event.preventDefault();
    
    const selectedClass = classSelect.value;
    const selectedSubject = subjectSelect.value;
    const selectedTimeSlot = timeSlotSelect.value;
    
    // Vérification des champs obligatoires
    if (!selectedClass || !selectedSubject || !selectedTimeSlot) {
      toast.show('Informations manquantes', 'Veuillez sélectionner une classe, une matière et un horaire.', 'error');
      return;
    }
    
    // Simuler l'envoi des données (attente de 1.5 secondes)
    submitBtn.disabled = true;
    submitBtn.textContent = 'Enregistrement...';
    
    setTimeout(() => {
      isSubmitted = true;
      
      // Mettre à jour l'interface
      renderStudentsList();
      
      // Modifier les boutons
      resetBtn.textContent = 'Nouvel appel';
      submitBtn.style.display = 'none';
      
      // Afficher un message de confirmation
      const absentCount = absentStudents.size;
      toast.show(
        'Appel enregistré', 
        `${absentCount} élève(s) absent(s) sur ${students.length}. Les parents ont été notifiés.`
      );
      
      // Réactiver le bouton
      resetBtn.disabled = false;
    }, 1500);
  }
  
  // Réinitialiser le formulaire
  function handleFormReset() {
    if (isSubmitted) {
      // Si déjà soumis, préparer un nouvel appel
      absentStudents.clear();
      isSubmitted = false;
      
      // Réinitialiser les champs
      subjectSelect.value = '';
      timeSlotSelect.value = '';
      students = [];
      
      // Réinitialiser l'interface
      studentsList.innerHTML = `
        <div class="placeholder-message">
          <p>Veuillez sélectionner une classe pour afficher la liste des élèves</p>
        </div>
      `;
      
      // Rétablir les boutons
      resetBtn.textContent = 'Réinitialiser';
      submitBtn.style.display = 'block';
      submitBtn.textContent = 'Enregistrer l\'appel';
      submitBtn.disabled = false;
      
      // Réinitialiser la classe
      classSelect.value = '';
    } else {
      // Sinon, juste réinitialiser les absences
      absentStudents.clear();
      renderStudentsList();
    }
  }
  
  // Gestionnaires d'événements
  if (classSelect) {
    classSelect.addEventListener('change', function() {
      loadStudents(this.value);
    });
  }
  
  if (attendanceForm) {
    attendanceForm.addEventListener('submit', handleFormSubmit);
  }
  
  if (resetBtn) {
    resetBtn.addEventListener('click', handleFormReset);
  }
  
  // Ajouter la fonction toggleAbsence à la portée globale pour les checkboxes
  window.toggleAbsence = toggleAbsence;
  
  // Vérifier les paramètres d'URL au chargement
  checkQueryParams();
});
