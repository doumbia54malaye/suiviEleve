# ===== URLS.PY (App) =====
from django.urls import path
from . import views
from django.views.generic import TemplateView

app_name = 'gestionAbst'

urlpatterns = [
    
    # Dashboard
    path('', views.index, name='index'),
    path('dashboard/', views.dashboard_view, name='dashboard'),
    path('students/', views.students, name='students'), 
    path('compteUser/', views.compte_utilisateur, name='compteUser'),
    path('logout/', views.logout_view, name='logout'),
    # Inscription et modification d'élèves
    path('inscriptions/', views.inscription_eleve, name='inscription_eleve'),
    path('modifier/<int:eleve_id>/', views.modifier_eleve, name='modifier_eleve'),
    path('liste/', views.liste_eleves, name='liste_eleves'),
    path('eleves/<int:eleve_id>/modifier/', views.modifier_eleve, name='modifier_eleve'),
    path('eleves/<int:eleve_id>/supprimer/', views.supprimer_eleve, name='supprimer_eleve'),
 
    # API AJAX
    path('api/verifier-matricule/', views.verifier_matricule, name='verifier_matricule'),

    #gestion enseignements
    path('inscription_enseignant/', views.inscription_enseignant, name='inscription_enseignant'),
    path('liste_enseignants/', views.vue_liste_enseignements, name='liste_enseignements'),
    path('enseignements/export/', views.export_enseignements, name='export_enseignements'),
    path('enseignements/<int:enseignement_id>/modifier/', views.modifier_enseignement, name='modifier_enseignement'),
    path('enseignements/<int:enseignement_id>/details/', views.vue_detail_enseignement, name='detail_enseignement'),
    path('supprimer_enseignant/<int:enseignant_id>/', views.supprimer_enseignant, name='supprimer_enseignant'),
    path('enseignements/<int:enseignement_id>/seances/', views.vue_seances_enseignement, name='seances_enseignement'),
        # Gestion des utilisateurs
    path('inscription/', views.inscription_utilisateur, name='inscription_utilisateur'),
    path('utilisateurs/', views.liste_utilisateurs, name='liste_utilisateurs'),
    path('utilisateurs/<int:user_id>/modifier/', views.modifier_utilisateur, name='modifier_utilisateur'),
    path('utilisateurs/<int:user_id>/supprimer/', views.supprimer_utilisateur, name='supprimer_utilisateur'),
    path('statistiques/', views.statistiques_utilisateurs, name='statistiques_utilisateurs'),
    
    # API endpoints pour validation AJAX
    path('verifier-username/', views.verifier_username, name='verifier_username'),
    path('verifier-email/', views.verifier_email, name='verifier_email'),

    # Liste et détails des élèves
    path('', views.liste_eleves, name='liste_eleves'),
    path('detail/<int:eleve_id>/', views.detail_eleve, name='detail_eleve'),
    
    # Suppression d'élève
    path('supprimer/<int:eleve_id>/', views.supprimer_eleve, name='supprimer_eleve'),
    
    # AJAX pour vérification matricule
    path('verifier-matricule/', views.verifier_matricule, name='verifier_matricule'),

    #connexion et authentification
    path('api/auth/login/', views.login_api, name='login_api'),
    path('api/auth/logout/', views.logout_api, name='logout_api'),
    path('api/auth/check/', views.check_auth, name='check_auth'),

    # API pour les données du dashboard admin
    path('api/admin/dashboard-data/', views.api_admin_dashboard_data, name='api_admin_dashboard_data'),
    
    # API pour les données du dashboard parent (que vous aviez déjà)
    path('api/parent/dashboard-data/', views.api_parent_dashboard_data, name='api_parent_dashboard_data'),

    # Gestion des séances
    path('seances/', views.seance_list, name='seance_list'),
    path('seances/create/', views.seance_create, name='seance_create'),
    path('seances/<int:pk>/', views.seance_detail, name='seance_detail'),
    path('seances/<int:pk>/appel/', views.faire_appel, name='faire_appel'),
    
    # Gestion des notes
    path('notes/', views.note_list, name='note_list'),
    path('notes/create/', views.note_create, name='note_create'),
    path('eleves/<int:eleve_id>/notes/', views.eleve_notes, name='eleve_notes'),
    
    # API endpoints
    path('api/save-attendance/', views.save_attendance, name='save_attendance'),
    path('api/save-grade/', views.save_grade, name='save_grade'),
  
]
