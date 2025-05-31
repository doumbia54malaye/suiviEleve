
document.addEventListener('DOMContentLoaded', function() {
  // Éléments du DOM
  const gradesForm = document.getElementById('gradesForm');
  const classSelect = document.getElementById('class');
  const subjectSelect = document.getElementById('subject');
  const evalTypeSelect = document.getElementById('evalType');
  const evalDateInput = document.getElementById('evalDate');
  const evalTitleInput = document.getElementById('evalTitle');
  const studentsGrades = document.getElementById('studentsGrades');
  const resetBtn = document.getElementById('resetBtn');
  const submitBtn = document.getElementById('submitBtn');
  
  // Variables d'état
  let students = [];
  let isSubmitted = false;
  
  // Initialiser la date à aujourd'hui
  if (evalDateInput) {
    const today = new Date();
    const formattedDate = today.toISOString().split('T')[0];
    evalDateInput.value = formattedDate;
  }
  
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
  
  // Générer des élèves fictifs pour une classe
  function generateMockStudents(className) {
    const count = 10 + Math.floor(Math.random() * 15); // Entre 10 et 25 élèves
    return Array.from({ length: count }, (_, i) => ({
      id: `student-${className.replace(/\s+/g, '')}-${i}`,
      firstName: `Prénom ${i + 1}`,
      lastName: `Nom ${i + 1}`,
      grade: null
    }));
  }
  
  // Charger les élèves pour une classe
  function loadStudents(className) {
    if (!className) return;
    
    // Réinitialiser
    isSubmitted = false;
    
    // Générer des élèves fictifs
    students = generateMockStudents(className);
    
    // Mettre à jour l'interface
    renderStudentsList();
  }
  
  // Calculer la moyenne de classe
  function calculateClassAverage() {
    const grades = students
      .map(student => student.grade)
      .filter(grade => grade !== null && !isNaN(grade));
    
    if (grades.length === 0) return "-";
    
    const sum = grades.reduce((acc, grade) => acc + grade, 0);
    return (sum / grades.length).toFixed(2);
  }
  
  // Afficher la liste des élèves
  function renderStudentsList() {
    if (!studentsGrades || !students.length) {
      studentsGrades.innerHTML = `
        <div class="placeholder-message">
          <p>Aucun élève dans cette classe</p>
        </div>
      `;
      return;
    }
    
    const average = calculateClassAverage();
    
    let html = `
      <div class="students-header">
        <h3>Liste des élèves</h3>
        <div class="class-average">Moyenne de classe: <span>${average}/20</span></div>
      </div>
      <table>
        <thead>
          <tr>
            <th>Nom</th>
            <th>Prénom</th>
            <th class="text-right">Note / 20</th>
          </tr>
        </thead>
        <tbody>
    `;
    
    students.forEach(student => {
      html += `
        <tr>
          <td>${student.lastName}</td>
          <td>${student.firstName}</td>
          <td class="text-right">
            ${isSubmitted ? 
              `<div class="grade-display">
                <span>${student.grade !== null ? `${student.grade}/20` : '-'}</span>
                ${student.grade !== null ? '<span class="grade-sent">✓</span>' : ''}
              </div>` :
              `<input type="number" 
                id="${student.id}" 
                class="grade-input" 
                min="0" 
                max="20" 
                step="0.5" 
                value="${student.grade !== null ? student.grade : ''}" 
                oninput="updateGrade('${student.id}', this.value)">`
            }
          </td>
        </tr>
      `;
    });
    
    html += `
        </tbody>
      </table>
    `;
    
    studentsGrades.innerHTML = html;
    
    // Ajouter des gestionnaires pour les inputs de notes
    if (!isSubmitted) {
      const gradeInputs = studentsGrades.querySelectorAll('.grade-input');
      gradeInputs.forEach(input => {
        input.addEventListener('input', function() {
          updateGrade(this.id, this.value);
        });
      });
    }
  }
  
  // Mettre à jour la note d'un élève
  function updateGrade(studentId, value) {
    const numValue = parseFloat(value);
    
    // Vérifier si la valeur est un nombre valide entre 0 et 20
    if (isNaN(numValue) || numValue < 0 || numValue > 20) {
      if (value === '') {
        // Si le champ est vide, mettre la note à null
        const student = students.find(s => s.id === studentId);
        if (student) {
          student.grade = null;
        }
      }
      return;
    }
    
    // Mettre à jour la note
    const student = students.find(s => s.id === studentId);
    if (student) {
      student.grade = numValue;
    }
  }
  
  // Gérer la soumission du formulaire
  function handleFormSubmit(event) {
    event.preventDefault();
    
    const selectedClass = classSelect.value;
    const selectedSubject = subjectSelect.value;
    const selectedEvalType = evalTypeSelect.value;
    const evaluationTitle = evalTitleInput.value;
    
    // Vérification des champs obligatoires
    if (!selectedClass || !selectedSubject || !selectedEvalType || !evaluationTitle) {
      toast.show('Informations manquantes', 'Veuillez remplir tous les champs obligatoires.', 'error');
      return;
    }
    
    // Vérifier si au moins un élève a une note
    const hasGrades = students.some(student => student.grade !== null);
    if (!hasGrades) {
      toast.show('Notes manquantes', 'Veuillez saisir au moins une note.', 'error');
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
      resetBtn.textContent = 'Nouvelle saisie';
      submitBtn.style.display = 'none';
      
      // Afficher un message de confirmation
      const gradedStudentsCount = students.filter(s => s.grade !== null).length;
      toast.show(
        'Notes enregistrées', 
        `${gradedStudentsCount} note(s) enregistrée(s). Les parents ont été notifiés.`
      );
      
      // Réactiver le bouton
      resetBtn.disabled = false;
    }, 1500);
  }
  
  // Réinitialiser le formulaire
  function handleFormReset() {
    if (isSubmitted) {
      // Si déjà soumis, préparer une nouvelle saisie
      isSubmitted = false;
      
      // Réinitialiser les champs
      subjectSelect.value = '';
      evalTypeSelect.value = '';
      evalTitleInput.value = '';
      
      const today = new Date();
      evalDateInput.value = today.toISOString().split('T')[0];
      
      students = [];
      
      // Réinitialiser l'interface
      studentsGrades.innerHTML = `
        <div class="placeholder-message">
          <p>Veuillez sélectionner une classe pour saisir les notes</p>
        </div>
      `;
      
      // Rétablir les boutons
      resetBtn.textContent = 'Réinitialiser';
      submitBtn.style.display = 'block';
      submitBtn.textContent = 'Enregistrer les notes';
      submitBtn.disabled = false;
      
      // Réinitialiser la classe
      classSelect.value = '';
    } else {
      // Sinon, juste réinitialiser les notes
      students.forEach(student => {
        student.grade = null;
      });
      renderStudentsList();
    }
  }
  
  // Gestionnaires d'événements
  if (classSelect) {
    classSelect.addEventListener('change', function() {
      loadStudents(this.value);
    });
  }
  
  if (gradesForm) {
    gradesForm.addEventListener('submit', handleFormSubmit);
  }
  
  if (resetBtn) {
    resetBtn.addEventListener('click', handleFormReset);
  }
  
  // Ajouter la fonction updateGrade à la portée globale pour les inputs
  window.updateGrade = updateGrade;
  
  // Ajouter des styles supplémentaires
  const style = document.createElement('style');
  style.textContent = `
    .grade-input {
      width: 60px;
      text-align: right;
      margin-left: auto;
    }
    
    .grade-display {
      display: flex;
      align-items: center;
      justify-content: flex-end;
    }
    
    .grade-sent {
      margin-left: 0.5rem;
      color: var(--success);
      font-size: 0.875rem;
    }
  `;
  
  document.head.appendChild(style);
});
