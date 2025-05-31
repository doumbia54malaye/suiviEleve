// Students management JavaScript

// Mock students data

// DOM Elements

const studentCountElement = document.getElementById('studentCount');
const classFilterElement = document.getElementById('classFilter');
const studentSearchElement = document.getElementById('studentSearch');
const addStudentBtn = document.getElementById('addStudentBtn');
const studentModal = document.getElementById('studentModal');
const closeModalBtn = document.getElementById('closeModal');
const cancelBtn = document.getElementById('cancelBtn');
const studentForm = document.getElementById('studentForm');
const saveStudentBtn = document.getElementById('saveStudentBtn');
const modalTitleElement = document.getElementById('modalTitle');
const studentIdInput = document.getElementById('studentId');
const deleteModal = document.getElementById('deleteModal');
const closeDeleteModalBtn = document.getElementById('closeDeleteModal');
const cancelDeleteBtn = document.getElementById('cancelDeleteBtn');
const confirmDeleteBtn = document.getElementById('confirmDeleteBtn');
const printListBtn = document.getElementById('printList');
const exportDataBtn = document.getElementById('exportData');


// Students management JavaScript - Version corrigée

// Mock students data
const MOCK_STUDENTS = [
    { id: '1', firstName: 'Jean', lastName: 'Dupont', class: '6e A', birthDate: '12/05/2013', parentPhone: '06 12 34 56 78', absences: 2, averageGrade: 15},
    { id: '3', firstName: 'Lucas', lastName: 'Bernard', class: '5e B', birthDate: '05/03/2012', parentPhone: '06 34 56 78 90', absences: 5, averageGrade: 12.8 },
    { id: '4', firstName: 'Emma', lastName: 'Petit', class: '5e B', birthDate: '17/11/2012', parentPhone: '06 45 67 89 01', absences: 1, averageGrade: 15.0 },
    { id: '5', firstName: 'Thomas', lastName: 'Richard', class: '4e A', birthDate: '30/09/2011', parentPhone: '06 56 78 90 12', absences: 3, averageGrade: 11.5 },
    { id: '6', firstName: 'Chloé', lastName: 'Durand', class: '4e A', birthDate: '02/02/2011', parentPhone: '06 67 89 01 23', absences: 0, averageGrade: 17.3 },
    { id: '7', firstName: 'Hugo', lastName: 'Moreau', class: '3e C', birthDate: '14/06/2010', parentPhone: '06 78 90 12 34', absences: 4, averageGrade: 13.7 },
    { id: '8', firstName: 'Léa', lastName: 'Simon', class: '3e C', birthDate: '08/12/2010', parentPhone: '06 89 01 23 45', absences: 2, averageGrade: 14.2 },

];

// DOM Elements
const studentsTableBody = document.getElementById('studentsTableBody');
// ... (autres sélections d'éléments DOM)

// State
let students = [...MOCK_STUDENTS];
let filteredStudents = [...MOCK_STUDENTS];
let studentToDelete = null;

// Initialize
document.addEventListener('DOMContentLoaded', () => {
    initAuth();  // Changé de checkAuth() à initAuth()
    renderStudentsTable();
    setupEventListeners();
});

// Nouvelle fonction d'initialisation d'authentification
function initAuth() {
    // Mode développement - permet l'accès sans authentification en local
    const isLocalDev = window.location.hostname === 'localhost' || window.location.hostname === '127.0.0.1';
    
    const userRole = sessionStorage.getItem('userRole');
    const userName = sessionStorage.getItem('userName') || 'Utilisateur';
    
    // Mise à jour du nom d'utilisateur dans la navbar
    const userNameElement = document.getElementById('userName');
    if (userNameElement) {
        userNameElement.textContent = userName;
    }
    
    // Si on est en production et que l'utilisateur n'est pas authentifié
    if (!isLocalDev && !userRole) {
        console.warn('Redirection vers index.html - Utilisateur non authentifié');
        window.location.href = 'index.html';
        return;
    }
    
    // Si l'utilisateur n'a pas les droits nécessaires
    if (!isLocalDev && userRole !== 'teacher' && userRole !== 'admin') {
        console.warn('Redirection vers dashboard.html - Droits insuffisants');
        window.location.href = 'dashboard.html';
        return;
    }
    
    // Si tout est OK, on continue
    console.log('Authentification validée - Rôle:', userRole);
}

// ... (le reste de vos fonctions reste inchangé)

// Setup event listeners
function setupEventListeners() {
    // Filter and search
    classFilterElement.addEventListener('change', filterStudents);
    studentSearchElement.addEventListener('input', filterStudents);
    
    // Add student modal
    addStudentBtn.addEventListener('click', openAddStudentModal);
    closeModalBtn.addEventListener('click', closeStudentModal);
    cancelBtn.addEventListener('click', closeStudentModal);
    
    // Save student
    saveStudentBtn.addEventListener('click', saveStudent);
    
    // Delete confirmation modal
    closeDeleteModalBtn.addEventListener('click', closeDeleteModal);
    cancelDeleteBtn.addEventListener('click', closeDeleteModal);
    confirmDeleteBtn.addEventListener('click', deleteStudent);
    
    // Print and Export
    printListBtn.addEventListener('click', printStudentList);
    exportDataBtn.addEventListener('click', exportStudentData);
}

// Render students table
function renderStudentsTable() {
    studentsTableBody.innerHTML = '';
    
    if (filteredStudents.length === 0) {
        const emptyRow = document.createElement('tr');
        emptyRow.innerHTML = `
            <td colspan="7" class="text-center">Aucun élève trouvé</td>
        `;
        studentsTableBody.appendChild(emptyRow);
    } else {
        filteredStudents.forEach(student => {
            const row = document.createElement('tr');
            
            // Determine badge color for absences
            let absenceBadgeClass = 'badge-low';
            if (student.absences > 3) {
                absenceBadgeClass = 'badge-high';
            } else if (student.absences > 1) {
                absenceBadgeClass = 'badge-medium';
            }
            
            // Determine grade class
            let gradeClass = 'grade-average';
            if (student.averageGrade >= 14) {
                gradeClass = 'grade-good';
            } else if (student.averageGrade < 10) {
                gradeClass = 'grade-poor';
            }
            
            row.innerHTML = `
                <td class="student-name">${student.lastName} ${student.firstName}</td>
                <td>${student.class}</td>
                <td>${student.birthDate}</td>
                <td>${student.parentPhone}</td>
                <td><span class="badge-absences ${absenceBadgeClass}">${student.absences}</span></td>
                <td><span class="student-grade ${gradeClass}">${student.averageGrade}/20</span></td>
                <td class="action-cell">
                    <button class="btn btn-outline-secondary btn-sm edit-btn" data-id="${student.id}">Modifier</button>
                    <button class="btn btn-danger btn-sm delete-btn" data-id="${student.id}">Supprimer</button>
                </td>
            `;
            
            studentsTableBody.appendChild(row);
        });
        
        // Add event listeners to the buttons
        document.querySelectorAll('.edit-btn').forEach(button => {
            button.addEventListener('click', () => openEditStudentModal(button.dataset.id));
        });
        
        document.querySelectorAll('.delete-btn').forEach(button => {
            button.addEventListener('click', () => openDeleteConfirmation(button.dataset.id));
        });
    }
    
    // Update student count
    studentCountElement.textContent = `${filteredStudents.length} élèves au total`;
}

// Filter students based on class and search term
function filterStudents() {
    const classFilter = classFilterElement.value;
    const searchTerm = studentSearchElement.value.toLowerCase();
    
    filteredStudents = students.filter(student => {
        const matchesClass = !classFilter || student.class === classFilter;
        const matchesSearch = !searchTerm || 
                            student.firstName.toLowerCase().includes(searchTerm) || 
                            student.lastName.toLowerCase().includes(searchTerm);
        return matchesClass && matchesSearch;
    });
    
    renderStudentsTable();
}

// Open modal to add a new student
function openAddStudentModal() {
    modalTitleElement.textContent = 'Ajouter un nouvel élève';
    studentIdInput.value = '';
    studentForm.reset();
    studentModal.classList.add('show');
}

// Open modal to edit an existing student
function openEditStudentModal(studentId) {
    const student = students.find(s => s.id === studentId);
    
    if (student) {
        modalTitleElement.textContent = 'Modifier un élève';
        studentIdInput.value = student.id;
        
        // Fill the form with student data
        document.getElementById('firstName').value = student.firstName;
        document.getElementById('lastName').value = student.lastName;
        document.getElementById('class').value = student.class;
        document.getElementById('birthDate').value = student.birthDate;
        document.getElementById('parentPhone').value = student.parentPhone;
        
        studentModal.classList.add('show');
    }
}

// Close student modal
function closeStudentModal() {
    studentModal.classList.remove('show');
}

// Save student (add new or update existing)
function saveStudent() {
    // Get form values
    const firstName = document.getElementById('firstName').value.trim();
    const lastName = document.getElementById('lastName').value.trim();
    const classValue = document.getElementById('class').value;
    const birthDate = document.getElementById('birthDate').value.trim();
    const parentPhone = document.getElementById('parentPhone').value.trim();
    const studentId = studentIdInput.value;
    
    // Form validation
    if (!firstName || !lastName || !classValue || !birthDate || !parentPhone) {
        showToast('Erreur', 'Veuillez remplir tous les champs obligatoires.');
        return;
    }
    
    // Check if adding new or updating existing
    if (studentId) {
        // Update existing student
        const index = students.findIndex(s => s.id === studentId);
        
        if (index !== -1) {
            students[index] = {
                ...students[index],
                firstName,
                lastName,
                class: classValue,
                birthDate,
                parentPhone
            };
            
            showToast('Succès', `${firstName} ${lastName} a été modifié avec succès.`);
        }
    } else {
        // Add new student
        const newStudent = {
            id: Date.now().toString(),
            firstName,
            lastName,
            class: classValue,
            birthDate,
            parentPhone,
            absences: 0,
            averageGrade: 0
        };
        
        students.push(newStudent);
        showToast('Succès', `${firstName} ${lastName} a été ajouté avec succès.`);
    }
    
    // Close modal and update table
    closeStudentModal();
    filterStudents();
}

// Open delete confirmation modal
function openDeleteConfirmation(studentId) {
    studentToDelete = students.find(s => s.id === studentId);
    
    if (studentToDelete) {
        deleteModal.classList.add('show');
    }
}

// Close delete modal
function closeDeleteModal() {
    deleteModal.classList.remove('show');
    studentToDelete = null;
}

// Delete student
function deleteStudent() {
    if (studentToDelete) {
        students = students.filter(s => s.id !== studentToDelete.id);
        showToast('Succès', `${studentToDelete.firstName} ${studentToDelete.lastName} a été supprimé avec succès.`);
        closeDeleteModal();
        filterStudents();
    }
}

// Print student list
function printStudentList() {
    showToast('Information', 'Préparation de l\'impression de la liste des élèves...');
    
    // In a real application, we would prepare the document for printing
    // For demo purposes, just wait a bit then open the print dialog
    setTimeout(() => {
        window.print();
    }, 1000);
}

// Export student data to CSV
function exportStudentData() {
    showToast('Information', 'Exportation des données en cours...');
    
    // Create CSV content
    let csvContent = "data:text/csv;charset=utf-8,";
    csvContent += "Nom,Prénom,Classe,Date de naissance,Téléphone parent,Absences,Moyenne\n";
    
    filteredStudents.forEach(student => {
        csvContent += `${student.lastName},${student.firstName},${student.class},${student.birthDate},${student.parentPhone},${student.absences},${student.averageGrade}\n`;
    });
    
    // Create download link
    const encodedUri = encodeURI(csvContent);
    const link = document.createElement("a");
    link.setAttribute("href", encodedUri);
    link.setAttribute("download", "liste_eleves.csv");
    document.body.appendChild(link);
    
    // Trigger download
    setTimeout(() => {
        link.click();
        document.body.removeChild(link);
    }, 1000);
}

// Show toast notification
function showToast(title, message) {
    const toast = document.getElementById('toast');
    const toastTitle = document.getElementById('toastTitle');
    const toastMessage = document.getElementById('toastMessage');
    const closeToast = document.getElementById('closeToast');
    
    toastTitle.textContent = title;
    toastMessage.textContent = message;
    
    toast.classList.add('show');
    
    // Auto hide after 5 seconds
    setTimeout(() => {
        toast.classList.remove('show');
    }, 5000);
    
    // Close button
    closeToast.addEventListener('click', () => {
        toast.classList.remove('show');
    });
}
