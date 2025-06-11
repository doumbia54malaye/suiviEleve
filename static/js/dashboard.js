
document.addEventListener('DOMContentLoaded', function() {
  // Éléments du DOM
  const dashboardContent = document.getElementById('dashboardContent');
  
  // Récupérer le rôle de l'utilisateur
  const userRole = sessionStorage.getItem('userRole') || '';
  const userName = sessionStorage.getItem('userName') || 'Utilisateur';
  
  // Helper function pour échapper l'HTML et éviter les XSS
function escapeHtml(unsafe) {
  if (unsafe === null || typeof unsafe === 'undefined') return '';
  return unsafe
    .toString()
    .replace(/&/g, "&amp;")
    .replace(/</g, "&lt;")
    .replace(/>/g, "&gt;")
    .replace(/"/g, "&quot;")
    .replace(/'/g, "&#039;");
}


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

  // Fonction pour charger le contenu du tableau de bord en fonction du rôle
  // Fonction pour charger le contenu du tableau de bord en fonction du rôle
  async function loadDashboardContent() {
    if (!dashboardContent) return;
    
    let contentHtml = '';
    
    try {
        switch (userRole) {
        case 'parent':
            contentHtml = await generateParentDashboard(); // Doit aussi devenir async si elle fetch des données
            break;
        case 'teacher':
            contentHtml = await generateTeacherDashboard(); // Idem
            break;
        case 'admin':
            contentHtml = await generateAdminDashboard();
            break;
        default:
            contentHtml = '<div class="card"><div class="card-body"><p>Rôle non reconnu ou données non disponibles.</p></div></div>';
        }
    } catch (error) {
        console.error("Erreur lors du chargement du contenu du dashboard:", error);
        contentHtml = `<div class="card"><div class="card-body"><p>Erreur lors du chargement: ${escapeHtml(error.message)}</p></div></div>`;
    }
    
    dashboardContent.innerHTML = contentHtml;
  }
  
  // Générer le contenu du tableau de bord pour les parents
  function generateParentDashboard() {
    return `
      <div class="greeting-card">
        <div class="card">
          <div class="card-body">
            <h2>Bienvenue, ${userName}</h2>
            <p>Voici un résumé des informations concernant vos enfants.</p>
          </div>
        </div>
      </div>
      
      <div class="dashboard-cards">
        <div class="card">
          <div class="card-header">
            <h2>Dernières absences</h2>
          </div>
          <div class="card-body">
            <div class="absence-item">
              <div class="absence-date">17 juin 2023</div>
              <div class="absence-details">
                <h3>Emma Durant - 5e B</h3>
                <p>Absente pendant le cours de Mathématiques (8h-10h)</p>
              </div>
            </div>
            <div class="absence-item">
              <div class="absence-date">15 juin 2023</div>
              <div class="absence-details">
                <h3>Lucas Durant - 3e A</h3>
                <p>Absent pendant le cours d'Anglais (14h-16h)</p>
              </div>
            </div>
          </div>
          <div class="card-footer">
            <a href="absences.html" class="btn btn-outline-secondary">Voir toutes les absences</a>
          </div>
        </div>
        
        <div class="card">
          <div class="card-header">
            <h2>Dernières notes</h2>
          </div>
          <div class="card-body">
            <div class="grade-item">
              <div class="grade-date">18 juin 2023</div>
              <div class="grade-details">
                <div class="grade-header">
                  <h3>Emma Durant - Français</h3>
                  <div class="grade-value">16/20</div>
                </div>
                <p>Contrôle sur la poésie</p>
              </div>
            </div>
            <div class="grade-item">
              <div class="grade-date">14 juin 2023</div>
              <div class="grade-details">
                <div class="grade-header">
                  <h3>Lucas Durant - Mathématiques</h3>
                  <div class="grade-value">14/20</div>
                </div>
                <p>Contrôle sur les fractions</p>
              </div>
            </div>
          </div>
          <div class="card-footer">
            <a href="grades-view.html" class="btn btn-outline-secondary">Voir toutes les notes</a>
          </div>
        </div>
      </div>
    `;
  }
  
// Générer le contenu dynamique du tableau de bord enseignant
  async function generateTeacherDashboard() {
    try {
      // Récupérer les données du serveur
      const data = await apiRequest('/api/teacher/dashboard/');
      
      if (!data.success) {
        throw new Error(data.error || 'Erreur lors du chargement des données');
      }

      return `
        <div class="greeting-card">
          <div class="card">
            <div class="card-body">
              <h2>Bienvenue, ${escapeHtml(data.user_name)}</h2>
              <p>Voici un résumé de vos cours pour aujourd'hui.</p>
            </div>
          </div>
        </div>
        
        <!-- Statistiques rapides -->
        <div class="dashboard-stats">
          <div class="stat-card">
            <div class="stat-icon">
              <i class="fa-solid fa-chalkboard-user"></i>
            </div>
            <div class="stat-content">
              <div class="stat-value">${data.stats.total_classes}</div>
              <div class="stat-label">Classes</div>
            </div>
          </div>
          
          <div class="stat-card">
            <div class="stat-icon">
              <i class="fa-solid fa-calendar-week"></i>
            </div>
            <div class="stat-content">
              <div class="stat-value">${data.stats.seances_semaine}</div>
              <div class="stat-label">Séances cette semaine</div>
            </div>
          </div>
          
          <div class="stat-card">
            <div class="stat-icon">
              <i class="fa-solid fa-user-check"></i>
            </div>
            <div class="stat-content">
              <div class="stat-value">${data.stats.seances_sans_appel}</div>
              <div class="stat-label">Appels à faire</div>
            </div>
          </div>
          
          <div class="stat-card">
            <div class="stat-icon">
              <i class="fa-solid fa-clipboard-list"></i>
            </div>
            <div class="stat-content">
              <div class="stat-value">${data.stats.notes_a_saisir}</div>
              <div class="stat-label">Notes à saisir</div>
            </div>
          </div>
        </div>
        
        <div class="dashboard-cards">
          <div class="card">
            <div class="card-header">
              <h2>Cours d'aujourd'hui</h2>
            </div>
            <div class="card-body">
              ${data.seances_today.length > 0 ? generateSeancesHtml(data.seances_today) : 
                '<p class="text-muted">Aucun cours programmé pour aujourd\'hui</p>'}
            </div>
          </div>
          
          <div class="card">
            <div class="card-header">
              <h2>Actions rapides</h2>
            </div>
            <div class="card-body">
              <div class="quick-actions">
                <a href="/attendance/" class="quick-action-btn">
                  <i class="fa-solid fa-user-check"></i>
                  <span>Faire l'appel</span>
                </a>
                <a href="grades.html" class="quick-action-btn">
                  <i class="fa-solid fa-clipboard-list"></i>
                  <span>Saisir des notes</span>
                </a>
                <a href="schedule.html" class="quick-action-btn">
                  <i class="fa-solid fa-calendar"></i>
                  <span>Emploi du temps</span>
                </a>
                <a href="students.html" class="quick-action-btn">
                  <i class="fa-solid fa-users"></i>
                  <span>Mes élèves</span>
                </a>
              </div>
            </div>
          </div>
        </div>
      `;
    } catch (error) {
      console.error('Erreur lors du chargement du dashboard:', error);
      return `
        <div class="card">
          <div class="card-body">
            <div class="alert alert-danger">
              <i class="fa-solid fa-exclamation-triangle"></i>
              Erreur lors du chargement des données: ${escapeHtml(error.message)}
            </div>
          </div>
        </div>
      `;
    }
  }

  // Générer le HTML pour les séances
  function generateSeancesHtml(seances) {
    return seances.map(seance => `
      <div class="schedule-item">
        <div class="schedule-time">${seance.heure_debut} - ${seance.heure_fin}</div>
        <div class="schedule-details">
          <h3>${escapeHtml(seance.matiere)} - ${escapeHtml(seance.classe)}</h3>
          ${seance.description ? `<p>${escapeHtml(seance.description)}</p>` : ''}
          ${seance.appel_fait ? 
            '<span class="badge badge-success">Appel fait</span>' : 
            '<span class="badge badge-warning">Appel à faire</span>'
          }
        </div>
        <div class="schedule-actions">
          ${!seance.appel_fait ? 
            `<a href="attendance.html?seance_id=${seance.id}" class="btn btn-sm btn-primary">
              <i class="fa-solid fa-user-check"></i> Faire l'appel
            </a>` : 
            `  <a href="/attendance/?seance_id=${seance.id}&view=1" class="btn btn-sm btn-info">
            <i class="fa-solid fa-eye"></i> Voir l'appel
        </a>`
          }
        </div>
      </div>
    `).join('');
  }
  
  // Générer le contenu du tableau de bord pour les administrateurs
  // Générer le contenu du tableau de bord pour les administrateurs (MODIFIÉ)
  async function generateAdminDashboard() {
    try {
      const response = await fetch('/api/admin/dashboard-data/'); // URL de votre API
      if (!response.ok) {
        const errorData = await response.json().catch(() => ({ message: 'Erreur HTTP inconnue' }));
        throw new Error(`Erreur ${response.status}: ${errorData.message || response.statusText}`);
      }
      const data = await response.json();

      if (!data.success) {
        throw new Error(data.message || 'Échec de la récupération des données admin.');
      }

      let absencesHtml = '';
      if (data.recent_absences && data.recent_absences.length > 0) {
        absencesHtml = data.recent_absences.map(absence => `
          <tr>
            <td>${escapeHtml(absence.date)}</td>
            <td>${escapeHtml(absence.student_name)}</td>
            <td>${escapeHtml(absence.class_name)}</td>
            <td>${escapeHtml(absence.subject)} (${escapeHtml(absence.time_slot)})</td>
            <td>${absence.notified ? '<i class="fa-solid fa-check text-success"></i>' : '<i class="fa-solid fa-times text-danger"></i>'}</td>
          </tr>
        `).join('');
      } else {
        absencesHtml = '<tr><td colspan="5">Aucune absence récente à afficher.</td></tr>';
      }

      return `
        <div class="greeting-card">
          <div class="card">
            <div class="card-body">
              <h2>Bienvenue, ${escapeHtml(data.userName)}</h2>
              <p>Voici un aperçu des statistiques de l'établissement.</p>
            </div>
          </div>
        </div>
        
        <div class="dashboard-stats">
          <div class="stat-card">
            <div class="stat-icon"><i class="fa-solid fa-users"></i></div>
            <div class="stat-content">
              <div class="stat-value">${escapeHtml(data.stats.students_count)}</div>
              <div class="stat-label">Élèves</div>
            </div>
          </div>
          <div class="stat-card">
            <div class="stat-icon"><i class="fa-solid fa-chalkboard-teacher"></i></div>
            <div class="stat-content">
              <div class="stat-value">${escapeHtml(data.stats.teachers_count)}</div>
              <div class="stat-label">Enseignants</div>
            </div>
          </div>
          <div class="stat-card">
            <div class="stat-icon"><i class="fa-solid fa-door-open"></i></div>
            <div class="stat-content">
              <div class="stat-value">${escapeHtml(data.stats.classes_count)}</div>
              <div class="stat-label">Classes</div>
            </div>
          </div>
          <div class="stat-card">
            <div class="stat-icon"><i class="fa-solid fa-calendar-xmark"></i></div>
            <div class="stat-content">
              <div class="stat-value">${escapeHtml(data.stats.absences_today_count)}</div>
              <div class="stat-label">${escapeHtml(data.stats.absence_rate_label)}</div>
            </div>
          </div>
        </div>
        
        <div class="dashboard-cards">
          <div class="card">
            <div class="card-header"><h2>Absences Récentes (5 dernières)</h2></div>
            <div class="card-body">
              <table>
                <thead>
                  <tr>
                    <th>Date</th>
                    <th>Élève</th>
                    <th>Classe</th>
                    <th>Cours</th>
                    <th>Notifié</th>
                  </tr>
                </thead>
                <tbody>
                  ${absencesHtml}
                </tbody>
              </table>
            </div>
            <div class="card-footer">
              <a href="/admin/gestion/presence/" class="btn btn-outline-secondary">Voir toutes les absences</a>
            </div>
          </div>
          
          <div class="card">
            <div class="card-header"><h2>Actions rapides</h2></div>
            <div class="card-body">
              <div class="quick-actions">
                <a href="/inscriptions/" class="quick-action-btn">  
                  <i class="fa-solid fa-user-plus"></i>
                  <span>Ajouter un élève</span>
                </a>
                 <a href="/liste_utilisateurs/" class="quick-action-btn">
                  <i class="fa-solid fa-users-cog"></i>
                  <span>Gérer Utilisateurs</span>
                </a>
                <a href="/admin/gestion/classe/add/" class="quick-action-btn">
                  <i class="fa-solid fa-plus"></i>
                  <span>Créer une classe</span>
                </a>
                <a href="/inscription_enseignant/" class="quick-action-btn"> <!-- Lien vers la liste des enseignements -->
                  <i class="fa-solid fa-calendar-plus"></i>
                  <span>Gérer enseignements</span>
                </a>
              </div>
            </div>
          </div>
        </div>
      `;
    } catch (error) {
        console.error("Erreur lors de la génération du dashboard admin:", error);
        return `<div class="card"><div class="card-body"><p>Erreur critique lors du chargement des données admin: ${escapeHtml(error.message)}</p></div></div>`;
    }
  }
  
  // Charger le contenu du tableau de bord
  loadDashboardContent();
  
  // Ajouter des styles supplémentaires pour le dashboard
  const style = document.createElement('style');
  style.textContent = `
    .greeting-card {
      margin-bottom: 1.5rem;
    }
    
    .greeting-card h2 {
      font-size: 1.5rem;
      margin-bottom: 0.5rem;
    }
    
    .dashboard-cards {
      display: grid;
      grid-template-columns: 1fr;
      gap: 1.5rem;
    }
    
    @media (min-width: 992px) {
      .dashboard-cards {
        grid-template-columns: repeat(2, 1fr);
      }
    }
    
    .absence-item, .grade-item, .schedule-item {
      padding: 1rem 0;
      border-bottom: 1px solid var(--border-color);
    }
    
    .absence-item:last-child, .grade-item:last-child, .schedule-item:last-child {
      border-bottom: none;
    }
    
    .absence-date, .grade-date, .schedule-time {
      font-size: 0.75rem;
      color: var(--gray);
      margin-bottom: 0.5rem;
    }
    
    .absence-details h3, .grade-details h3, .schedule-details h3 {
      font-size: 0.875rem;
      font-weight: 600;
      margin-bottom: 0.25rem;
    }
    
    .absence-details p, .grade-details p, .schedule-details p {
      font-size: 0.75rem;
      color: var(--gray);
    }
    
    .grade-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
    }
    
    .grade-value {
      font-weight: 600;
      color: var(--primary);
    }
    
    .schedule-item {
      display: flex;
      align-items: center;
    }
    
    .schedule-time {
      flex: 0 0 80px;
      margin-bottom: 0;
    }
    
    .schedule-details {
      flex: 1;
    }
    
    .schedule-actions {
      flex: 0 0 auto;
    }
    
    .todo-item {
      display: flex;
      align-items: center;
      padding: 0.5rem 0;
    }
    
    .todo-item input[type="checkbox"] {
      margin-right: 0.75rem;
    }
    
    .dashboard-stats {
      display: grid;
      grid-template-columns: repeat(2, 1fr);
      gap: 1rem;
      margin-bottom: 1.5rem;
    }
    
    @media (min-width: 768px) {
      .dashboard-stats {
        grid-template-columns: repeat(4, 1fr);
      }
    }
    
    .stat-card {
      background-color: var(--white);
      border-radius: var(--border-radius);
      box-shadow: var(--shadow);
      padding: 1.25rem;
      display: flex;
      align-items: center;
    }
    
    .stat-icon {
      display: flex;
      align-items: center;
      justify-content: center;
      width: 3rem;
      height: 3rem;
      background-color: rgba(13, 110, 253, 0.1);
      color: var(--primary);
      border-radius: 50%;
      font-size: 1.25rem;
      margin-right: 1rem;
    }
    
    .stat-value {
      font-size: 1.5rem;
      font-weight: 700;
      margin-bottom: 0.25rem;
    }
    
    .stat-label {
      font-size: 0.75rem;
      color: var(--gray);
    }
    
    .quick-actions {
      display: grid;
      grid-template-columns: repeat(2, 1fr);
      gap: 1rem;
    }
    
    .quick-action-btn {
      display: flex;
      flex-direction: column;
      align-items: center;
      text-align: center;
      padding: 1rem;
      background-color: var(--light);
      border-radius: var(--border-radius);
      color: var(--dark);
      text-decoration: none;
      transition: var(--transition);
    }
    
    .quick-action-btn:hover {
      background-color: var(--primary);
      color: var(--white);
    }
    
    .quick-action-btn i {
      font-size: 1.5rem;
      margin-bottom: 0.5rem;
    }
    
    .text-success {
      color: var(--success);
    }
  `;

  
  
  document.head.appendChild(style);
});
