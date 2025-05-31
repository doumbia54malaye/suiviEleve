
document.addEventListener('DOMContentLoaded', function() {
  // Vérifier si l'utilisateur est connecté
  if (sessionStorage.getItem('isLoggedIn') !== 'true') {
    window.location.href = 'index.html';
    return;
  }
  
  // Récupérer les informations utilisateur
  const userRole = sessionStorage.getItem('userRole') || '';
  const userName = sessionStorage.getItem('userName') || 'Utilisateur';
  
  // Éléments du DOM
  const userNameElement = document.getElementById('userName');
  const userRoleElement = document.getElementById('userRole');
  const userInitialsElement = document.getElementById('userInitials');
  const roleSpecificLinks = document.getElementById('roleSpecificLinks');
  const menuToggle = document.getElementById('menuToggle');
  const sidebar = document.getElementById('sidebar');
  const sidebarToggle = document.getElementById('sidebarToggle');
  const notificationBtn = document.getElementById('notificationBtn');
  const notificationDropdown = document.getElementById('notificationDropdown');
  const userBtn = document.getElementById('userBtn');
  const userDropdown = document.getElementById('userDropdown');
  const logoutBtn = document.getElementById('logoutBtn');
  
  // Configuration des toasts
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
  
  // Gestionnaire pour le bouton de fermeture du toast
  if (toast.close) {
    toast.close.addEventListener('click', function() {
      toast.hide();
    });
  }
  
  // Obtenir les initiales de l'utilisateur
  function getInitials(name) {
    if (!name) return 'EC';
    const names = name.split(' ');
    if (names.length > 1) {
      return `${names[0][0]}${names[1][0]}`.toUpperCase();
    }
    return name.slice(0, 2).toUpperCase();
  }
  
  // Mettre à jour les informations utilisateur dans l'interface
  if (userNameElement) userNameElement.textContent = userName;
  if (userRoleElement) userRoleElement.textContent = userRole;
  if (userInitialsElement) userInitialsElement.textContent = getInitials(userName);
  
  // Ajouter les liens spécifiques au rôle dans la sidebar
  if (roleSpecificLinks) {
    let links = '';
    
    switch (userRole) {
      case 'parent':
        links = `
          <a href="absences.html" class="sidebar-link">
            <i class="fa-solid fa-calendar-xmark"></i>
            <span>Absences</span>
          </a>
          <a href="grades-view.html" class="sidebar-link">
            <i class="fa-solid fa-graduation-cap"></i>
            <span>Notes</span>
          </a>
        `;
        break;
      case 'teacher':
        links = `
          <a href="attendance.html" class="sidebar-link">
            <i class="fa-solid fa-clipboard-check"></i>
            <span>Faire l'appel</span>
          </a>
          <a href="grades.html" class="sidebar-link">
            <i class="fa-solid fa-pen-to-square"></i>
            <span>Saisir les notes</span>
          </a>
          <a href="students/" class="sidebar-link">
            <i class="fa-solid fa-users"></i>
            <span>Élèves</span>
          </a>
        `;
        break;
      case 'admin':
        links = `
          <a href="students/" class="sidebar-link">
            <i class="fa-solid fa-users"></i>
            <span>Élèves</span>
          </a>
          <a href="teacher-management.html" class="sidebar-link">
            <i class="fa-solid fa-chalkboard-teacher"></i>
            <span>Enseignants</span>
          </a>
          <a href="class-management.html" class="sidebar-link">
            <i class="fa-solid fa-book-open"></i>
            <span>Classes</span>
          </a>
          <a href="schedule-management.html" class="sidebar-link">
            <i class="fa-solid fa-calendar-days"></i>
            <span>Emplois du temps</span>
          </a>
          <a href="statistics.html" class="sidebar-link">
            <i class="fa-solid fa-chart-bar"></i>
            <span>Statistiques</span>
          </a>
          <a href="settings.html" class="sidebar-link">
            <i class="fa-solid fa-cog"></i>
            <span>Paramètres</span>
          </a>
        `;
        break;
    }
    
    roleSpecificLinks.innerHTML = links;
  }
  
  // Gérer le toggle du sidebar sur mobile
  if (menuToggle && sidebar) {
    menuToggle.addEventListener('click', function() {
      sidebar.classList.toggle('show');
    });
    
    // Fermer le sidebar si on clique en dehors
    document.addEventListener('click', function(event) {
      const isClickInsideSidebar = sidebar.contains(event.target);
      const isClickOnMenuToggle = menuToggle.contains(event.target);
      
      if (!isClickInsideSidebar && !isClickOnMenuToggle && sidebar.classList.contains('show')) {
        sidebar.classList.remove('show');
      }
    });
  }
  
  // Gérer le toggle du collapse sidebar
  if (sidebarToggle && sidebar) {
    sidebarToggle.addEventListener('click', function() {
      document.body.classList.toggle('sidebar-collapsed');
    });
  }
  
  // Gérer les dropdowns
  function setupDropdown(trigger, dropdown) {
    if (!trigger || !dropdown) return;
    
    trigger.addEventListener('click', function(event) {
      event.stopPropagation();
      dropdown.classList.toggle('show');
    });
    
    // Fermer le dropdown si on clique en dehors
    document.addEventListener('click', function(event) {
      if (!trigger.contains(event.target) && dropdown.classList.contains('show')) {
        dropdown.classList.remove('show');
      }
    });
  }
  
  // Configurer les dropdowns
  setupDropdown(notificationBtn, notificationDropdown);
  setupDropdown(userBtn, userDropdown);
  
  // Gérer la déconnexion
  if (logoutBtn) {
    logoutBtn.addEventListener('click', function(event) {
      event.preventDefault();
      
      // Supprimer les données de session
      sessionStorage.clear();
      
      // Rediriger vers la page de connexion
      window.location.href = 'index.html';
    });
  }
  
  // Marquer le lien actif dans la sidebar
  const currentPage = window.location.pathname.split('/').pop();
  const sidebarLinks = document.querySelectorAll('.sidebar-link');
  
  sidebarLinks.forEach(link => {
    const href = link.getAttribute('href');
    if (href === currentPage) {
      link.classList.add('active');
    }
  });
});
