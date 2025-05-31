# views.py
from django.http import JsonResponse, HttpResponse # Assurez-vous que HttpResponse est importé
from django.contrib.auth import authenticate, login, logout # Assurez-vous que logout est importé
from django.views.decorators.csrf import csrf_exempt
from django.views.decorators.http import require_http_methods
import json
from .models import CustomUser, Eleve, Classe, Presence, Seance # Importez les modèles nécessaires
# from .forms import EleveForm # Décommentez si utilisé ailleurs
from django.shortcuts import render
from django.contrib.auth.decorators import login_required
from django.utils import timezone # Pour filtrer les absences du jourfrom django.contrib.auth import authenticate, login
from django.views.decorators.csrf import csrf_exempt
from django.views.decorators.http import require_http_methods
import json
from .models import *
from .forms import EleveForm
from django.shortcuts import render
from django.contrib.auth.decorators import login_required
from django.shortcuts import redirect
from django.views.decorators.http import require_POST


def index(request):
    # Concernant ce chemin de template, voir la note plus bas
    return render(request, 'index.html') 
# views.py
def students(request):
    return render(request, 'students.html')

#vue form pour dashboard admin
@login_required
def dashboard_view(request):
    eleves = Eleve.objects.all()

    context = {
        'user_first_name': request.user.first_name,
        'user_last_name': request.user.last_name,
        'user_role': request.user.user_type,
        'eleves': eleves,
      
    }
    return render(request, 'dashboard.html', context)


# --- Vues pour les séances (à développer) ---
def seance_list(request):
    # Logique pour lister les séances
    return HttpResponse("Page de la liste des séances (à implémenter)")

def seance_create(request):
    # Logique pour créer une séance
    return HttpResponse("Page de création de séance (à implémenter)")

def seance_detail(request, pk):
    # Logique pour afficher le détail d'une séance
    return HttpResponse(f"Page de détail de la séance {pk} (à implémenter)")

def faire_appel(request, pk):
    # Logique pour faire l'appel pour une séance
    return HttpResponse(f"Page pour faire l'appel de la séance {pk} (à implémenter)")

# --- Vues pour les notes (à développer) ---
def note_list(request):
    return HttpResponse("Page de la liste des notes (à implémenter)")

def note_create(request):
    return HttpResponse("Page de création de note (à implémenter)")

def eleve_notes(request, eleve_id):
    return HttpResponse(f"Page des notes de l'élève {eleve_id} (à implémenter)")

# --- Vues pour les API (à développer) ---
def save_attendance(request):
    return JsonResponse({'message': 'API sauvegarde présence (à implémenter)'}) # JsonResponse si c'est une API

def save_grade(request):
    return JsonResponse({'message': 'API sauvegarde note (à implémenter)'}) # JsonResponse si c'est une API

@csrf_exempt
@require_http_methods(["POST"])
def login_api(request):
    try:
        # Parser les données JSON du frontend
        data = json.loads(request.body)
        email = data.get('email')
        password = data.get('password')
        role = data.get('role')
        
        # Vérifier que tous les champs sont présents
        if not email or not password or not role:
            return JsonResponse({
                'success': False,
                'message': 'Tous les champs sont requis'
            }, status=400)
        
        # Authentifier l'utilisateur avec l'email comme username
        user = authenticate(request, username=email, password=password)
        
        if user is not None:
            # Vérifier si le type d'utilisateur correspond au rôle sélectionné
            if user.user_type != role and role != 'parent':  # 'parent' peut ne pas exister dans votre modèle
                return JsonResponse({
                    'success': False,
                    'message': 'Type de compte incorrect'
                }, status=401)
            
            # Connecter l'utilisateur
            login(request, user)
            
            return JsonResponse({
                'success': True,
                'message': 'Connexion réussie',
                'user': {
                    'id': user.id,
                    'email': user.email,
                    'first_name': user.first_name,
                    'last_name': user.last_name,
                    'user_type': user.user_type,
                    'full_name': f"{user.first_name} {user.last_name}"
                }
            })
        else:
            return JsonResponse({
                'success': False,
                'message': 'Email ou mot de passe incorrect'
            }, status=401)
            
    except json.JSONDecodeError:
        return JsonResponse({
            'success': False,
            'message': 'Données JSON invalides'
        }, status=400)
    except Exception as e:
        return JsonResponse({
            'success': False,
            'message': 'Erreur serveur'
        }, status=500)

@require_http_methods(["POST"])
def logout_api(request):
    logout(request)
    return JsonResponse({
        'success': True,
        'message': 'Déconnexion réussie'
    })

def logout_view(request):
    logout(request)
    return redirect('index') 
@require_http_methods(["GET"])
def check_auth(request):
    """Vérifier si l'utilisateur est connecté"""
    if request.user.is_authenticated:
        return JsonResponse({
            'authenticated': True,
            'user': {
                'id': request.user.id,
                'email': request.user.email,
                'first_name': request.user.first_name,
                'last_name': request.user.last_name,
                'user_type': request.user.user_type,
                'full_name': f"{request.user.first_name} {request.user.last_name}"
            }
        })
    else:
        return JsonResponse({
            'authenticated': False
        })
    

@login_required
@require_http_methods(["GET"]) # S'assurer que c'est une requête GET
def api_admin_dashboard_data(request):
    if request.user.user_type != 'admin':
        return JsonResponse({'error': 'Accès non autorisé'}, status=403)

    students_count = Eleve.objects.filter(actif=True).count()
    teachers_count = CustomUser.objects.filter(user_type='teacher', is_active=True).count()
    classes_count = Classe.objects.count() # Ou filtrez par année scolaire active si pertinent

    # Pour le taux d'absence, c'est un peu plus complexe.
    # Simplifions pour l'instant avec le nombre d'absences aujourd'hui.
    today = timezone.now().date()
    absences_today_count = Presence.objects.filter(
        statut='absent', 
        seance__date=today
    ).count()
    
    # Taux d'absence (exemple simple : absences totales / (élèves * jours d'école) - à affiner)
    # Pour un vrai taux d'absence, il faudrait considérer les jours où il y a eu cours.
    # total_possible_presences = Eleve.objects.count() * Seance.objects.filter(date__lte=today).values('date').distinct().count()
    # total_absences = Presence.objects.filter(statut='absent').count()
    # absence_rate = (total_absences / total_possible_presences) * 100 if total_possible_presences > 0 else 0
    # Pour la démo, nous allons garder le nombre d'absences du jour.

    # Absences récentes (5 dernières)
    recent_absences_qs = Presence.objects.filter(statut='absent') \
                                     .select_related('eleve', 'seance__enseignement__matiere', 'eleve__classe') \
                                     .order_by('-seance__date', '-seance__heure_debut')[:5]
    
    recent_absences_data = []
    for presence in recent_absences_qs:
        recent_absences_data.append({
            'date': presence.seance.date.strftime("%d %B %Y"),
            'student_name': f"{presence.eleve.nom} {presence.eleve.prenoms}",
            'class_name': presence.eleve.classe.nom if presence.eleve.classe else "N/A",
            'subject': presence.seance.enseignement.matiere.nom if presence.seance.enseignement and presence.seance.enseignement.matiere else "N/A",
            'time_slot': f"{presence.seance.heure_debut.strftime('%Hh%M')} - {presence.seance.heure_fin.strftime('%Hh%M')}",
            'notified': presence.sms_envoye  # Supposant que vous avez un champ sms_envoye
        })

    data = {
        'success': True,
        'userName': f"{request.user.first_name} {request.user.last_name}", # Nom de l'admin connecté
        'stats': {
            'students_count': students_count,
            'teachers_count': teachers_count,
            'classes_count': classes_count,
            'absences_today_count': absences_today_count, # ou absence_rate si calculé
            'absence_rate_label': "Absences Aujourd'hui" # ou "Taux d'absence"
        },
        'recent_absences': recent_absences_data
    }
    return JsonResponse(data)

#les vue API

#API PARENTS
@login_required
def api_parent_dashboard_data(request):
    if request.user.user_type != 'parent':
        return JsonResponse({'error': 'Accès non autorisé'}, status=403)

    parent = request.user
    enfants = Eleve.objects.filter(parents=parent) # Supposons une relation ManyToMany 'parents' sur Eleve

    enfants_data = []
    for enfant in enfants:
        # Dernières absences (ex: 3 dernières)
        dernieres_absences = Absence.objects.filter(eleve=enfant).order_by('-date_absence')[:3]
        absences_list = [
            {
                'date': absence.date_absence.strftime('%d %B %Y'), # Formattez la date
                'matiere': absence.seance.matiere.nom if absence.seance and absence.seance.matiere else 'N/A',
                'details': absence.motif or f"Cours de {absence.seance.matiere.nom if absence.seance else 'N/A'}",
                'heure_debut': absence.seance.heure_debut.strftime('%Hh%M') if absence.seance else '',
                'heure_fin': absence.seance.heure_fin.strftime('%Hh%M') if absence.seance else ''
            } for absence in dernieres_absences
        ]

        # Dernières notes (ex: 3 dernières)
        dernieres_notes = Note.objects.filter(eleve=enfant).order_by('-evaluation__date')[:3] # Supposons que Note a FK vers Evaluation qui a une date
        notes_list = [
            {
                'date': note.evaluation.date.strftime('%d %B %Y'),
                'matiere': note.evaluation.matiere.nom,
                'valeur': f"{note.valeur}/{note.evaluation.bareme_total}",
                'description': note.evaluation.titre
            } for note in dernieres_notes
        ]

        enfants_data.append({
            'id': enfant.id,
            'nom_complet': f"{enfant.user.first_name} {enfant.user.last_name}", # Supposons qu'Eleve a une FK vers CustomUser
            'classe': enfant.classe.nom if enfant.classe else 'N/A', # Supposons qu'Eleve a une FK vers Classe
            'absences': absences_list,
            'notes': notes_list,
        })

    return JsonResponse({
        'success': True,
        'enfants_data': enfants_data,
        'userName': f"{parent.first_name} {parent.last_name}"
    })
