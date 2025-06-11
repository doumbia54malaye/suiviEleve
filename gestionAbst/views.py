# views.py
from django.http import JsonResponse, HttpResponse # Assurez-vous que HttpResponse est importé
from django.contrib.auth import authenticate, login, logout # Assurez-vous que logout est importé
from django.views.decorators.csrf import csrf_exempt
from django.views.decorators.http import require_http_methods, require_POST
from django.contrib.auth.decorators import login_required, user_passes_test
from django.utils import timezone # Pour filtrer les absences du jourfrom django.contrib.auth import authenticate, login
from django.contrib import messages
from django.shortcuts import render, redirect, get_object_or_404
from django.urls import reverse
from django.contrib.auth.models import User
from django.contrib.auth import authenticate, login
from django.core.exceptions import ValidationError
from django.core.validators import validate_email
from django.db import transaction
from datetime import date, datetime, timedelta
from .models import *
from .forms import *
import json
import re
from django.db.models import Q




def index(request):
   
    return render(request, 'index.html') 

def students(request):
    return render(request, 'students.html')
def compte_utilisateur(request):
    return render(request, 'compteUser.html')
def detail(request):
    return render(request, 'detail.html')
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
def detail_enseignant(request):
    # Logique pour afficher le détail d'une séance
    return HttpResponse(f"page de detail enseignant  (à implémenter)")
def vue_detail_enseignement(request, enseignement_id):
    # On récupère l'objet enseignement correspondant à l'ID, ou une erreur 404 s'il n'existe pas
    enseignement = get_object_or_404(Enseignement, pk=enseignement_id)
    
    # Pour l'instant, on retourne juste une réponse simple. 
    # Plus tard, vous rendrez un vrai template ici.
    return HttpResponse(f"<h1>Détails pour l'enseignement ID: {enseignement.id}</h1>"
                        f"<p>Enseignant: {enseignement.enseignant}</p>"
                        f"<p>Matière: {enseignement.matiere}</p>"
                        f"<p>Classe: {enseignement.classe}</p>")

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
    return redirect('gestionAbst:index')
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
#inscriptions des élèves

def inscription_eleve(request):
    """Vue pour l'inscription d'un nouvel élève"""
    if request.method == 'POST':
        form = EleveForm(request.POST)
        if form.is_valid():
            eleve = form.save()
            messages.success(
                request, 
                f"L'élève {eleve.nom_complet} a été inscrit avec succès ! Matricule: {eleve.matricule}"
            )
            return redirect('gestionAbst:liste_eleves')  # Remplacez par votre URL de liste
        else:
            messages.error(request, "Veuillez corriger les erreurs ci-dessous.")
    else:
        form = EleveForm()
    
    context = {
        'form': form,
        'title': 'Inscription d\'un nouvel élève',
        'classes': Classe.objects.all()
    }
    return render(request, 'inscriptions.html', context)

def modifier_eleve(request, eleve_id):
    """Vue pour modifier un élève existant"""
    eleve = get_object_or_404(Eleve, id=eleve_id)
    
    if request.method == 'POST':
        form = EleveForm(request.POST, instance=eleve)
        if form.is_valid():
            eleve = form.save()
            messages.success(
                request, 
                f"Les informations de {eleve.nom_complet} ont été mises à jour avec succès."
            )
            return redirect('detail_eleve', eleve_id=eleve.id)
        else:
            messages.error(request, "Veuillez corriger les erreurs ci-dessous.")
    else:
        form = EleveForm(instance=eleve)
    
    context = {
        'form': form,
        'eleve': eleve,
        'title': f'Modifier {eleve.nom_complet}',
        'classes': Classe.objects.all()
    }
    return render(request, 'inscriptions.html', context)


def liste_eleves(request):
    """
    Vue pour afficher la liste des élèves avec des filtres
    de recherche, de classe et de statut.
    """
    # 1. On commence par récupérer tous les élèves.
    eleves = Eleve.objects.select_related('classe').order_by('-created_at')

    # 2. On récupère les valeurs des filtres depuis l'URL (via la méthode GET).
    search_query = request.GET.get('search', '')
    classe_selectionnee = request.GET.get('classe', '')
    statut_selectionne = request.GET.get('statut', '')

    # 3. On applique les filtres s'ils existent.
    if search_query:
        # On recherche dans le nom, le prénom et le matricule.
        # L'objet Q permet de faire une recherche avec un "OU" logique.
        eleves = eleves.filter(
            Q(nom__icontains=search_query) | 
            Q(prenoms__icontains=search_query) | 
            Q(matricule__icontains=search_query)
        )

    if classe_selectionnee:
        # On filtre par l'ID de la classe.
        eleves = eleves.filter(classe__id=classe_selectionnee)

    if statut_selectionne:
        # On filtre par le statut "actif" ou "inactif".
        if statut_selectionne == 'actif':
            eleves = eleves.filter(actif=True)
        elif statut_selectionne == 'inactif':
            eleves = eleves.filter(actif=False)

    # 4. On récupère toutes les classes pour le menu déroulant du filtre.
    classes = Classe.objects.all()

    # 5. On prépare le contexte à envoyer au template.
    context = {
        'title': 'Gestion des Élèves',
        'eleves': eleves,
        'classes': classes,
        # On renvoie les valeurs des filtres au template pour qu'il puisse
        # pré-remplir les champs du formulaire.
        'classe_selectionnee': classe_selectionnee,
        'statut_selectionne': statut_selectionne,
    }

    # 6. On rend le template avec le contexte.
    # Assurez-vous que votre fichier template s'appelle bien 'liste_eleves.html'
    return render(request, 'liste_eleves.html', context)
    
    # Recherche textuelle
    # Recherche textuelle
    search = request.GET.get('search')
    if search:
        eleves = eleves.filter(
            Q(nom__icontains=search) |
            Q(prenoms__icontains=search) |
            Q(matricule__icontains=search)
        )
    # Filtrage optionnel par classe
    classe_id = request.GET.get('classe')
    if classe_id:
        eleves = eleves.filter(classe_id=classe_id)
    
    # Filtrage par statut (actif/inactif)
    statut = request.GET.get('statut')
    if statut == 'actif':
        eleves = eleves.filter(actif=True)
    elif statut == 'inactif':
        eleves = eleves.filter(actif=False)
    
    context = {
        'eleves': eleves,
        'classes': Classe.objects.all(),
        'classe_selectionnee': classe_id,
        'statut_selectionne': statut,
        'title': 'Liste des élèves'
    }
    return render(request, 'liste.html', context)

def detail_eleve(request, eleve_id):
    """Vue pour afficher les détails d'un élève"""
    eleve = get_object_or_404(Eleve, id=eleve_id)
    
    context = {
        'eleve': eleve,
        'title': f'Détails de {eleve.nom_complet}'
    }
    return render(request, 'detail.html', context)

@require_http_methods(["POST"])
def supprimer_eleve(request, eleve_id):
    """Vue pour supprimer un élève"""
    eleve = get_object_or_404(Eleve, id=eleve_id)
    nom_complet = eleve.nom_complet
    
    eleve.delete()
    messages.success(request, f"L'élève {nom_complet} a été supprimé avec succès.")
    
    return redirect('gestionAbst:liste_eleves')

def verifier_matricule(request):
    """Vue AJAX pour vérifier si un matricule existe déjà"""
    matricule = request.GET.get('matricule')
    eleve_id = request.GET.get('eleve_id')  # Pour l'édition
    
    if matricule:
        query = Eleve.objects.filter(matricule=matricule)
        if eleve_id:  # En mode édition, exclure l'élève actuel
            query = query.exclude(id=eleve_id)
        
        existe = query.exists()
        return JsonResponse({'existe': existe})
    
    return JsonResponse({'existe': False})

#vue pour l'inscription d'un enseignant

def inscription_enseignant(request):
    if request.method == 'POST':
        enseignant_id = request.POST.get('enseignant')
        annee_scolaire = request.POST.get('annee_scolaire')
        
        try:
            enseignant = CustomUser.objects.get(id=enseignant_id, user_type='teacher')
            
            # Récupérer tous les enseignements
            enseignements_crees = []
            index = 0
            
            while f'matiere_{index}' in request.POST:
                matiere_id = request.POST.get(f'matiere_{index}')
                classe_id = request.POST.get(f'classe_{index}')
                
                if matiere_id and classe_id:
                    enseignement, created = Enseignement.objects.get_or_create(
                        enseignant=enseignant,
                        matiere_id=matiere_id,
                        classe_id=classe_id,
                        annee_scolaire=annee_scolaire
                    )
                    if created:
                        enseignements_crees.append(enseignement)
                
                index += 1
            
            if enseignements_crees:
                messages.success(request, f'{len(enseignements_crees)} enseignement(s) créé(s) avec succès.')
                return redirect('gestionAbst:liste_enseignements')
            else:
                messages.warning(request, 'Aucun nouvel enseignement créé.')
                
        except Exception as e:
            messages.error(request, f'Erreur lors de la création : {str(e)}')
    
    context = {
        'title': 'Inscription d\'un enseignant',
        'enseignants': CustomUser.objects.filter(user_type='teacher', is_active=True),
        'matieres': Matiere.objects.all().order_by('nom'),
        'classes': Classe.objects.all().order_by('niveau', 'nom'),
    }
    
    return render(request, 'inscription_enseignant.html', context)
def vue_liste_enseignements(request):

    # --- 1. Récupérer les données de la base de données ---

    # Récupérer tous les enseignements. 
    # Le .select_related() est une optimisation pour éviter trop de requêtes SQL.
    enseignements = Enseignement.objects.select_related(
        'enseignant', 'matiere', 'classe'
    ).all()

    # Calculer les statistiques
    total_enseignements = enseignements.count()
    total_enseignants = CustomUser.objects.filter(user_type='teacher', is_active=True).count()
    total_matieres = Matiere.objects.count()
    total_classes = Classe.objects.count()
    
    # --- 2. Préparer le contexte pour le template ---
    context = {
        'title': "Liste des Enseignements",  # Votre variable titre (j'ai changé le nom pour correspondre au template)

        # Les données pour le tableau
        'enseignements': enseignements,

        # Les données pour les cartes de statistiques
        'total_enseignements': total_enseignements,
        'total_enseignants': total_enseignants,
        'total_matieres': total_matieres,
        'total_classes': total_classes,

        # Vous devrez aussi passer les années scolaires si vous utilisez le filtre
        'annees_scolaires': Enseignement.objects.values_list('annee_scolaire', flat=True).distinct().order_by('-annee_scolaire')
    }
    
    # --- 3. Rendre le template avec le contexte complet ---
    return render(request, 'liste_enseignants.html', context)
def vue_seances_enseignement(request, enseignement_id):
    enseignement = get_object_or_404(Enseignement, pk=enseignement_id)
    
    # Plus tard, vous afficherez la liste des séances pour cet enseignement
    return HttpResponse(f"<h1>Gestion des séances pour l'enseignement :</h1>"
                        f"<p>{enseignement.matiere} en classe {enseignement.classe}</p>")

def modifier_enseignement(request, enseignement_id):
    return HttpResponse(f"Page de modification de l'enseignement {enseignement_id} (à implémenter)"),

def supprimer_enseignant(request, enseignant_id):
    """Vue pour supprimer un enseignant"""
    enseignant = get_object_or_404(CustomUser, id=enseignant_id, user_type='teacher')
    nom_complet = f"{enseignant.first_name} {enseignant.last_name}"
    
    enseignant.delete()
    messages.success(request, f"L'enseignant {nom_complet} a été supprimé avec succès.")
    
    return redirect('gestionAbst:liste_enseignements')

def export_enseignements(request):
    # Exemple simple pour exporter en CSV
    response = HttpResponse(content_type='text/csv')
    response['Content-Disposition'] = 'attachment; filename="enseignements.csv"'
def is_admin(user):
    """Vérifier si l'utilisateur est admin"""
    return user.is_authenticated and (user.is_superuser or user.user_type == 'admin')
def is_admin(user):
    """Vérifier si l'utilisateur est admin"""
    return user.is_authenticated and (user.is_superuser or user.user_type == 'admin')

@login_required
@user_passes_test(is_admin)
def inscription_utilisateur(request):
    """Vue principale pour l'inscription d'un utilisateur"""
    if request.method == 'POST':
        form = CustomUserCreationForm(request.POST)
        
        if form.is_valid():
            try:
                with transaction.atomic():
                    user = form.save(commit=False)
                    # Ajout des champs manuellement si nécessaire
                    user.is_active = form.cleaned_data.get('is_active', True)
                    user.is_staff = form.cleaned_data.get('is_staff', False)
                    user.save()  # Sauvegarde finale
                    
                    # Debug - afficher les données
                    print("Utilisateur créé avec les données suivantes:")
                    print(f"Username: {user.username}")
                    print(f"Email: {user.email}")
                    print(f"Type: {user.user_type}")
                    print(f"Staff: {user.is_staff}")
                    print(f"Active: {user.is_active}")
                    
                    messages.success(request, f'Compte créé avec succès pour {user.get_full_name()}')
                    return redirect('gestionAbst:liste_utilisateurs')  # Redirection en cas de succès
                    
            except Exception as e:
                print(f"Erreur lors de la création: {str(e)}")
                messages.error(request, f'Une erreur est survenue: {str(e)}')
        else:
            # Afficher toutes les erreurs de validation
            print("Erreurs de formulaire:")
            for field, errors in form.errors.items():
                print(f"{field}: {errors}")
                for error in errors:
                    messages.error(request, f"{form.fields[field].label}: {error}")
    else:
        form = CustomUserCreationForm()
    
    return render(request, 'inscription_enseignant.html', {'form': form})
# Vues AJAX pour validation en temps réel
def verifier_username(request):
    """Vérifier si un nom d'utilisateur existe déjà"""
    username = request.GET.get('username', '').strip()
    
    if not username:
        return JsonResponse({'existe': False})
    
    existe = CustomUser.objects.filter(username=username).exists()
    return JsonResponse({'existe': existe})

def verifier_email(request):
    """Vérifier si une adresse email existe déjà"""
    email = request.GET.get('email', '').strip()
    
    if not email:
        return JsonResponse({'existe': False})
    
    # Valider le format email
    try:
        validate_email(email)
    except ValidationError:
        return JsonResponse({'existe': False, 'format_invalide': True})
    
    existe = CustomUser.objects.filter(email=email).exists()
    return JsonResponse({'existe': existe})

@login_required
@user_passes_test(is_admin)
# Assurez-vous que la fonction is_admin est bien définie
def liste_utilisateurs(request):
    """
    Vue complète pour afficher et filtrer la liste des utilisateurs.
    """
    # 1. On commence avec tous les utilisateurs
    users_qs = CustomUser.objects.all().order_by('last_name', 'first_name')

    # 2. On calcule les statistiques AVANT de filtrer la liste principale
    total_users = users_qs.count()
    admins_count = users_qs.filter(user_type='admin').count()
    teachers_count = users_qs.filter(user_type='teacher').count()
    parents_count = users_qs.filter(user_type='parent').count()

    # 3. On récupère les valeurs des filtres depuis l'URL (avec les bons noms)
    search_query = request.GET.get('search', '')
    user_type_selectionne = request.GET.get('user_type', '')
    statut_selectionne = request.GET.get('statut', '')

    # 4. On applique les filtres sur le queryset
    if search_query:
        users_qs = users_qs.filter(
            Q(username__icontains=search_query) |
            Q(first_name__icontains=search_query) |
            Q(last_name__icontains=search_query) |
            Q(email__icontains=search_query)
        )

    if user_type_selectionne:
        users_qs = users_qs.filter(user_type=user_type_selectionne)

    if statut_selectionne:
        if statut_selectionne == 'actif':
            users_qs = users_qs.filter(is_active=True)
        elif statut_selectionne == 'inactif':
            users_qs = users_qs.filter(is_active=False)

    # 5. On prépare le contexte avec les BONS noms de variables
    context = {
        'title': 'Gestion des Utilisateurs',
        'users': users_qs,  # La variable s'appelle 'users', comme dans le template
        'total_users': total_users,
        'admins_count': admins_count,
        'teachers_count': teachers_count,
        'parents_count': parents_count,
        'user_type_selectionne': user_type_selectionne, # On renvoie les filtres
        'statut_selectionne': statut_selectionne,
    }

    # 6. On rend le template. 
    # Assurez-vous que le chemin est correct. Si votre template est dans
    # templates/users/liste_utilisateurs.html, c'est bon. Sinon, ajustez-le.
    return render(request, 'liste_utilisateurs.html', context)

@login_required
@user_passes_test(is_admin)
def modifier_utilisateur(request, user_id):
    """Vue pour modifier un utilisateur existant"""
    try:
        user = CustomUser.objects.get(id=user_id)
    except CustomUser.DoesNotExist:
        messages.error(request, 'Utilisateur introuvable.')
        return redirect('gestionAbst:liste_utilisateurs')
    
    if request.method == 'POST':
        # Formulaire de modification (similaire au formulaire de création)
        form = CustomUserCreationForm(request.POST, instance=user)
        
        if form.is_valid():
            try:
                with transaction.atomic():
                    form.save()
                    messages.success(request, f'Utilisateur {user.username} modifié avec succès.')
                    return redirect('gestionAbst:liste_utilisateurs')
            except Exception as e:
                messages.error(request, f'Erreur lors de la modification: {str(e)}')
        else:
            for field, errors in form.errors.items():
                for error in errors:
                    messages.error(request, f'{field}: {error}')
    else:
        form = CustomUserCreationForm(instance=user)
    
    return render(request, 'modifier_utilisateur.html', {
        'form': form,
        'user_to_modify': user
    })

@login_required
@user_passes_test(is_admin)
def supprimer_utilisateur(request, user_id):
    """Vue pour supprimer un utilisateur"""
    try:
        user = CustomUser.objects.get(id=user_id)
    except CustomUser.DoesNotExist:
        messages.error(request, 'Utilisateur introuvable.')
        return redirect('gestionAbst:liste_utilisateurs')
    
    if request.method == 'POST':
        username = user.username
        user.delete()
        messages.success(request, f'Utilisateur {username} supprimé avec succès.')
        return redirect('gestionAbst:liste_utilisateurs')
    
    return render(request, 'confirmer_suppression.html', {'user_to_delete': user})
# Vue pour les statistiques (bonus)

@login_required
@user_passes_test(is_admin)
@require_POST  # N'autorise que les requêtes POST
def activer_utilisateur(request, user_id):
    """Vue pour activer un compte utilisateur."""
    try:
        user = CustomUser.objects.get(id=user_id)
        if user.is_active:
            messages.warning(request, f"L'utilisateur {user.username} est déjà actif.")
        else:
            user.is_active = True
            user.save(update_fields=['is_active'])
            messages.success(request, f"Le compte de l'utilisateur {user.username} a été activé.")
    except CustomUser.DoesNotExist:
        messages.error(request, "Utilisateur introuvable.")
    
    return redirect('gestionAbst:liste_utilisateurs')


@login_required
@user_passes_test(is_admin)
@require_POST  # N'autorise que les requêtes POST
def desactiver_utilisateur(request, user_id):
    """Vue pour désactiver un compte utilisateur."""
    # Empêche un administrateur de se désactiver lui-même
    if request.user.id == user_id:
        messages.error(request, "Vous ne pouvez pas désactiver votre propre compte.")
        return redirect('gestionAbst:liste_utilisateurs')
        
    try:
        user = CustomUser.objects.get(id=user_id)
        if not user.is_active:
            messages.warning(request, f"L'utilisateur {user.username} est déjà inactif.")
        else:
            user.is_active = False
            user.save(update_fields=['is_active'])
            messages.info(request, f"Le compte de l'utilisateur {user.username} a été désactivé.")
    except CustomUser.DoesNotExist:
        messages.error(request, "Utilisateur introuvable.")

    return redirect('gestionAbst:liste_utilisateurs')
def detail_utilisateur(request, user_id):
    """
    Affiche la page de détail pour un utilisateur spécifique.
    """
    # On récupère l'utilisateur ou on renvoie une erreur 404 s'il n'existe pas
    user_details = get_object_or_404(CustomUser, id=user_id)
    
    context = {
        'title': f'Détails de {user_details.username}',
        'user_details': user_details
    }
    
    # On va rendre un nouveau template pour cette page de détail
    return render(request, 'detail_utilisateur.html', context)
@login_required
@user_passes_test(is_admin)
def statistiques_utilisateurs(request):
    """Vue pour afficher les statistiques des utilisateurs"""
    from django.db.models import Count
    
    stats = {
        'total_users': CustomUser.objects.count(),
        'active_users': CustomUser.objects.filter(is_active=True).count(),
        'inactive_users': CustomUser.objects.filter(is_active=False).count(),
        'by_type': CustomUser.objects.values('user_type').annotate(count=Count('id')),
        'recent_users': CustomUser.objects.filter(
            created_at__gte=timezone.now() - timedelta(days=30)
        ).count(),
    }
    
    return render(request, 'users/statistiques.html', {'stats': stats})

#--------------------------------------------------------------------------------
#----------------------------espace enseignant------------------------------------
#--------------------------------------------------------------------------------
def vue_teacher_attendance(request):
    """Vue pour afficher l'interface d'appel pour un enseignement spécifique"""

    return render(request, 'attendance.html')

@login_required
@require_http_methods(["GET"])
def teacher_dashboard_data(request):
    """API pour récupérer les données du tableau de bord enseignant"""
    if request.user.user_type != 'teacher':
        return JsonResponse({'error': 'Accès non autorisé'}, status=403)
    
    try:
        # Récupérer les enseignements de l'enseignant
        enseignements = Enseignement.objects.filter(
            enseignant=request.user,
            annee_scolaire='2024-2025'
        ).select_related('classe', 'matiere')
        
        # Séances d'aujourd'hui
        today = timezone.now().date()
        seances_today = Seance.objects.filter(
            enseignement__enseignant=request.user,
            date=today
        ).select_related('enseignement__classe', 'enseignement__matiere').order_by('heure_debut')
        
        # Statistiques
        total_classes = enseignements.values('classe').distinct().count()
        total_seances_week = Seance.objects.filter(
            enseignement__enseignant=request.user,
            date__gte=today - timedelta(days=7)
        ).count()
        
        # Séances sans appel fait
        seances_sans_appel = Seance.objects.filter(
            enseignement__enseignant=request.user,
            appel_fait=False,
            date__lte=today
        ).count()
        
        # Notes à saisir (simulé - vous pouvez adapter selon vos besoins)
        notes_a_saisir = 5  # Exemple
        
        # Formater les données pour le JSON
        seances_data = []
        for seance in seances_today:
            seances_data.append({
                'id': seance.id,
                'classe': seance.enseignement.classe.nom,
                'matiere': seance.enseignement.matiere.nom,
                'heure_debut': seance.heure_debut.strftime('%H:%M'),
                'heure_fin': seance.heure_fin.strftime('%H:%M'),
                'description': seance.description,
                'appel_fait': seance.appel_fait
            })
        
        data = {
            'success': True,
            'user_name': f"{request.user.first_name} {request.user.last_name}".strip() or request.user.username,
            'stats': {
                'total_classes': total_classes,
                'seances_semaine': total_seances_week,
                'seances_sans_appel': seances_sans_appel,
                'notes_a_saisir': notes_a_saisir
            },
            'seances_today': seances_data,
            'enseignements': [
                {
                    'id': ens.id,
                    'classe': ens.classe.nom,
                    'matiere': ens.matiere.nom
                } for ens in enseignements
            ]
        }
        
        return JsonResponse(data)
        
    except Exception as e:
        return JsonResponse({'error': str(e)}, status=500)
@login_required


@login_required
@require_http_methods(["GET"])
def teacher_classes_students(request):
    """API pour récupérer les élèves d'un enseignement spécifique"""
    # Étape 1 : Récupérer le bon paramètre
    enseignement_id = request.GET.get('enseignement_id') # <-- Changement ici
    
    if not enseignement_id:
        # Erreur si le paramètre est manquant
        return JsonResponse({'success': False, 'error': 'ID d\'enseignement requis'}, status=400)
    
    try:
        # Étape 2 : Trouver l'enseignement par son ID et vérifier qu'il appartient bien à l'enseignant connecté
        enseignement = Enseignement.objects.get(
            id=enseignement_id,
            enseignant=request.user
        )
        
        # Si on arrive ici, l'enseignement existe et l'enseignant a le droit d'y accéder.
        # Plus besoin du .filter().first() et du check if not enseignement. .get() le fait pour nous.

        # Étape 3 : Récupérer la classe de cet enseignement et ensuite les élèves
        classe_de_l_enseignement = enseignement.classe
        eleves = Eleve.objects.filter(classe=classe_de_l_enseignement).order_by('nom', 'prenoms')
        
        eleves_data = [
            {
                'id': eleve.id,
                'nom': eleve.nom,
                'prenom': eleve.prenoms,
                # Utiliser getattr est plus sûr que hasattr + accès direct
                'numero_ordre': getattr(eleve, 'numero_ordre', None)
            } for eleve in eleves
        ]
        
        return JsonResponse({
            'success': True,
            'eleves': eleves_data,
            'classe_nom': classe_de_l_enseignement.nom
        })

    except Enseignement.DoesNotExist:
        # Si .get() ne trouve rien, il lève cette erreur
        return JsonResponse({'success': False, 'error': 'Enseignement non trouvé ou accès non autorisé'}, status=404)
        
    except Exception as e:
        # Pour le débogage, c'est bien de voir l'erreur dans la console du serveur
        print(f"Erreur inattendue dans teacher_classes_students: {e}") 
        return JsonResponse({'success': False, 'error': 'Une erreur interne est survenue.'}, status=500)
@login_required
@require_http_methods(["POST"])
def save_attendance(request):
    """API pour enregistrer l'appel"""
    if request.user.user_type != 'teacher':
        return JsonResponse({'error': 'Accès non autorisé'}, status=403)
    
    try:
        data = json.loads(request.body)
        enseignement_id = data.get('enseignement_id')
        date_seance = data.get('date')
        heure_debut = data.get('heure_debut')
        heure_fin = data.get('heure_fin')
        presences = data.get('presences', [])
        
        # Vérifier l'enseignement
        enseignement = Enseignement.objects.filter(
            id=enseignement_id,
            enseignant=request.user
        ).first()
        
        if not enseignement:
            return JsonResponse({'error': 'Enseignement non trouvé'}, status=404)
        
        # Créer ou récupérer la séance
        seance, created = Seance.objects.get_or_create(
            enseignement=enseignement,
            date=datetime.strptime(date_seance, '%Y-%m-%d').date(),
            heure_debut=datetime.strptime(heure_debut, '%H:%M').time(),
            defaults={
                'heure_fin': datetime.strptime(heure_fin, '%H:%M').time(),
                'appel_fait': True
            }
        )
        
        if not created:
            seance.appel_fait = True
            seance.save()
        
        # Enregistrer les présences
        for presence_data in presences:
            eleve_id = presence_data.get('eleve_id')
            statut = presence_data.get('statut', 'present')
            remarque = presence_data.get('remarque', '')
            
            Presence.objects.update_or_create(
                seance=seance,
                eleve_id=eleve_id,
                defaults={
                    'statut': statut,
                    'remarque': remarque
                }
            )
        
        # Compter les absents pour le retour
        absents_count = len([p for p in presences if p.get('statut') == 'absent'])
        
        return JsonResponse({
            'success': True,
            'message': f'Appel enregistré avec succès. {absents_count} élève(s) absent(s).',
            'seance_id': seance.id,
            'absents_count': absents_count
        })
        
    except Exception as e:
        return JsonResponse({'error': str(e)}, status=500)