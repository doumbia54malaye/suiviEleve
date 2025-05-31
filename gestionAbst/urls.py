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
     path('logout/', views.logout_view, name='logout'),
    
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
