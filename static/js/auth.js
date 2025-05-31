document.addEventListener('DOMContentLoaded', function() {
  // Éléments du DOM
  const loginForm = document.getElementById('loginForm');
  const loginButton = document.getElementById('loginButton');
  const demoButtons = document.querySelectorAll('.demo-buttons button');
  const emailInput = document.getElementById('email');
  const passwordInput = document.getElementById('password');
  const roleSelect = document.getElementById('role');
  
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
  toast.close.addEventListener('click', function() {
    toast.hide();
  });
  
  // Fonction pour effectuer la connexion via l'API Django
  async function authenticateUser(email, password, role) {
    try {
      const response = await fetch('/api/auth/login/', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          email: email,
          password: password,
          role: role
        })
      });
      
      const data = await response.json();
      
      if (data.success) {
        // Stocker les informations utilisateur en sessionStorage
        sessionStorage.setItem('userRole', data.user.user_type);
        sessionStorage.setItem('userName', data.user.full_name);
        sessionStorage.setItem('userEmail', data.user.email);
        sessionStorage.setItem('userId', data.user.id);
        sessionStorage.setItem('isLoggedIn', 'true');
        
        return { success: true, user: data.user, message: data.message };
      } else {
        return { success: false, message: data.message };
      }
    } catch (error) {
      console.error('Erreur de connexion:', error);
      return { success: false, message: 'Erreur de connexion au serveur' };
    }
  }
  
  // Fonction pour vérifier l'authentification
 // Dans static/js/auth.js
async function checkAuthentication() {
  try {
    const response = await fetch('/api/auth/check/', {
      method: 'GET',
      credentials: 'include'
    });

    const data = await response.json();

    if (data.authenticated) {
      sessionStorage.setItem('userRole', data.user.user_type);
      sessionStorage.setItem('userName', data.user.full_name);
      sessionStorage.setItem('userEmail', data.user.email);
      sessionStorage.setItem('userId', data.user.id);
      sessionStorage.setItem('isLoggedIn', 'true');

      // Si l'utilisateur est authentifié et n'est pas déjà sur la page du tableau de bord,
      // ou si vous voulez toujours forcer la redirection vers la "vraie" page de dashboard
      // au cas où il atterrirait sur la page de login alors qu'il est déjà connecté.
      if (window.location.pathname !== '/dashboard/') { // Optionnel: évite une redirection si déjà sur la bonne page
          window.location.href = '/dashboard/'; // <<< MODIFIÉ ICI
      }
    } else {
      // Si l'utilisateur n'est PAS authentifié et essaie d'accéder à une page protégée
      // (comme /dashboard/ directement), vous pourriez vouloir le rediriger vers la page de login.
      // Cela dépend de votre logique de routage côté client ou serveur.
      // Pour l'instant, on ne fait rien ici si pas authentifié, la page de login reste affichée.
    }
  } catch (error) {
    console.error('Erreur de vérification d\'authentification:', error);
    sessionStorage.clear();
  }
}
  
  // Gestion des connexions de démo
  demoButtons.forEach(button => {
    button.addEventListener('click', function() {
      const role = this.dataset.role;
      
      // Remplir les champs avec les valeurs de démo
      roleSelect.value = role;
      emailInput.value = `demo-${role}@ecole-connectee.fr`;
      passwordInput.value = 'password';
    });
  });
  
  // Gestion de la soumission du formulaire
  loginForm.addEventListener('submit', async function(event) {
    event.preventDefault();
    
    const email = emailInput.value.trim();
    const password = passwordInput.value.trim();
    const role = roleSelect.value;
    
    // Vérification des champs
    if (!email || !password || !role) {
      toast.show('Erreur de connexion', 'Veuillez remplir tous les champs.', 'error');
      return;
    }
    
    // Désactiver le bouton pendant la connexion
    loginButton.disabled = true;
    loginButton.textContent = 'Connexion en cours...';
    
    try {
      // Effectuer la connexion via l'API
      const result = await authenticateUser(email, password, role);
      
      if (result.success) {
        // Afficher un toast de succès
        toast.show('Connexion réussie', `Bienvenue ${result.user.full_name}`);
        
        // Redirection vers le tableau de bord après un court délai
        setTimeout(() => {
          window.location.href = '/dashboard/';
        }, 1000);
      } else {
        // Afficher l'erreur
        toast.show('Erreur de connexion', result.message, 'error');
        
        // Réactiver le bouton
        loginButton.disabled = false;
        loginButton.textContent = 'Se connecter';
      }
    } catch (error) {
      console.error('Erreur lors de la connexion:', error);
      toast.show('Erreur de connexion', 'Une erreur est survenue. Veuillez réessayer.', 'error');
      
      // Réactiver le bouton
      loginButton.disabled = false;
      loginButton.textContent = 'Se connecter';
    }
  });
  
  // Vérifier si l'utilisateur est déjà connecté au chargement de la page
  checkAuthentication();
});