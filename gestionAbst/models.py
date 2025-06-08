# ===== MODELS.PY =====
from django.db import models
from django.contrib.auth.models import AbstractUser
from django.core.validators import RegexValidator
from django.utils import timezone
from django.contrib.auth.models import AbstractUser
from django.utils import timezone
from datetime import date
import random   
import re
from django.core.exceptions import ValidationError
import uuid
class CustomUser(AbstractUser):
    USER_TYPE_CHOICES = [
        ('admin', 'Administrateur'),
        ('teacher', 'Enseignant'),
        ('parent', 'Parent'),  # Ajouté pour correspondre à votre formulaire
    ]
    
    user_type = models.CharField(max_length=10, choices=USER_TYPE_CHOICES, default='teacher')
    phone_number = models.CharField(max_length=20, blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return f"{self.username} ({self.get_user_type_display()})"
    
    groups = models.ManyToManyField(
        'auth.Group',
        verbose_name='groupes',
        blank=True,
        help_text='Les groupes auxquels appartient cet utilisateur.',
        related_name="customuser_groups",
        related_query_name="customuser",
    )
    user_permissions = models.ManyToManyField(
        'auth.Permission',
        verbose_name='permissions utilisateur',
        blank=True,
        help_text='Permissions spécifiques pour cet utilisateur.',
        related_name="customuser_permissions",
        related_query_name="customuser",
    )
    
    # Rendre l'email obligatoire et unique
    email = models.EmailField(unique=True, verbose_name="Email")
    
    # Utiliser l'email comme identifiant de connexion
    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS = ['username', 'first_name', 'last_name']
    
    def __str__(self):
        return f"{self.first_name} {self.last_name} ({self.get_user_type_display()})"
    
    class Meta:
        verbose_name = "Utilisateur personnalisé"
        verbose_name_plural = "Utilisateurs personnalisés"
    def save(self, *args, **kwargs):
        # Ajoutez des validations ou traitements avant sauvegarde
        if not self.username:
            raise ValueError("Le nom d'utilisateur est obligatoire")
        self.email = self.email.lower()  # Normalisation de l'email
        super().save(*args, **kwargs)
class Matiere(models.Model):
    nom = models.CharField(max_length=100, unique=True)
    code = models.CharField(max_length=10, unique=True)
    coefficient = models.DecimalField(max_digits=3, decimal_places=1, default=1.0)
    description = models.TextField(blank=True)

    def __str__(self):
        return f"{self.nom} ({self.code})"

    class Meta:
        verbose_name = "Matière"
        verbose_name_plural = "Matières"

class Classe(models.Model):
    nom = models.CharField(max_length=50, unique=True)
    niveau = models.CharField(max_length=20)
    capacite_max = models.IntegerField(default=30)
    
    def __str__(self):
        return self.nom
    
    class Meta:
        ordering = ['nom']
    created_at = models.DateTimeField(auto_now_add=True)

class Eleve(models.Model):
    # Informations personnelles
    nom = models.CharField(
        max_length=50, 
        verbose_name="Nom de famille",
        help_text="Nom de famille de l'élève"
    )
    prenoms = models.CharField(
        max_length=100, 
        verbose_name="Prénoms",
        help_text="Prénoms de l'élève (séparés par des espaces)"
    )
    date_naissance = models.DateField(
        verbose_name="Date de naissance",
        help_text="Format: JJ/MM/AAAA"
    )
    matricule = models.CharField(
        max_length=20, 
        unique=True,
        verbose_name="Matricule",
        help_text="Matricule unique de l'élève"
    )
    classe = models.ForeignKey(
        Classe, 
        on_delete=models.CASCADE, 
        related_name='eleves',
        verbose_name="Classe"
    )
    
    # Informations des parents/tuteurs
    nom_parent = models.CharField(
        max_length=100, 
        verbose_name="Nom du parent/tuteur",
        help_text="Nom complet du parent ou tuteur légal"
    )
    
    phone_regex = RegexValidator(
        regex=r'^\+?225?\d{8,10}$',
        message="Format attendu: '+225XXXXXXXX' ou '0XXXXXXXX'"
    )
    telephone_parent = models.CharField(
        validators=[phone_regex], 
        max_length=15,
        verbose_name="Téléphone parent",
        help_text="Numéro de téléphone du parent/tuteur"
    )
    email_parent = models.EmailField(
        blank=True, 
        null=True,
        verbose_name="Email parent",
        help_text="Adresse email du parent (optionnel)"
    )
    
    # Statut et métadonnées
    actif = models.BooleanField(
        default=True, 
        verbose_name="Élève actif",
        help_text="Cochez si l'élève est actuellement inscrit"
    )
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    
    def save(self, *args, **kwargs):
        """Génère automatiquement le matricule si pas défini"""
        if not self.matricule:
            self.matricule = self.generer_matricule()
        
        # Validation avant sauvegarde
        self.full_clean()
        super().save(*args, **kwargs)
    
    def generer_matricule(self):
        """Génère un matricule unique au format 8 chiffres + 1 lettre"""
        # Trouve le dernier matricule
        derniere_matricule = Eleve.objects.order_by('matricule').last()
        
        if derniere_matricule and derniere_matricule.matricule:
            try:
                # Extrait les chiffres du dernier matricule
                chiffres = int(derniere_matricule.matricule[:8])
                nouveau_num = chiffres + 1
            except (ValueError, IndexError):
                nouveau_num = 10000000  # Commence à 10000000
        else:
            nouveau_num = 10000000
        
        # Lettre aléatoire (A-Z)
        lettre = chr(random.randint(65, 90))  # 65=A, 90=Z
        
        return f"{nouveau_num:08d}{lettre}"
    @property
    def nom_complet(self):
        """Retourne le nom complet de l'élève"""
        return f"{self.nom} {self.prenoms}".strip()
    
    @property
    def age(self):
        """Calcule l'âge précis de l'élève"""
        if not self.date_naissance:
            return 0
            
        today = date.today()
        age = today.year - self.date_naissance.year
        
        # Ajuste si l'anniversaire n'est pas encore passé
        if (today.month, today.day) < (self.date_naissance.month, self.date_naissance.day):
            age -= 1
            
        return max(0, age)
    
    @property
    def age_detaille(self):
        """Retourne l'âge sous forme détaillée"""
        age = self.age
        if age == 0:
            return "Moins d'un an"
        elif age == 1:
            return "1 an"
        else:
            return f"{age} ans"
    
    @property
    def initiales(self):
        """Retourne les initiales de l'élève"""
        nom_parts = self.nom.split()
        prenoms_parts = self.prenoms.split()
        
        initiales = ""
        if nom_parts:
            initiales += nom_parts[0][0].upper()
        if prenoms_parts:
            initiales += prenoms_parts[0][0].upper()
            
        return initiales or "??"
    
    def clean(self):
        """Validation personnalisée du modèle"""
        errors = {}
        
        # Validation de la date de naissance
        if self.date_naissance:
            if self.date_naissance > date.today():
                errors['date_naissance'] = "La date de naissance ne peut pas être dans le futur."
            
            age = self.age
            if age < 2:
                errors['date_naissance'] = "L'élève doit avoir au moins 2 ans."
            elif age > 30:
                errors['date_naissance'] = "L'élève ne peut pas avoir plus de 30 ans."
        
        # Validation du nom et prénoms
        if self.nom:
            if not self.nom.replace(' ', '').replace('-', '').isalpha():
                errors['nom'] = "Le nom ne doit contenir que des lettres, espaces et tirets."
        
        if self.prenoms:
            if not self.prenoms.replace(' ', '').replace('-', '').isalpha():
                errors['prenoms'] = "Les prénoms ne doivent contenir que des lettres, espaces et tirets."
        
        # Validation du matricule (format et unicité)
        if self.matricule:
            if not re.match(r'^\d{8}[A-Z]$', self.matricule):
                errors['matricule'] = (
                    "Format invalide. Le matricule doit contenir 8 chiffres "
                    "suivis d'une lettre majuscule (ex: 10100891Z)."
                )
            elif len(self.matricule) != 9:
                errors['matricule'] = "Le matricule doit faire exactement 9 caractères."
        
        if errors:
            raise ValidationError(errors)
    
    def peut_etre_supprime(self):
        """Vérifie si l'élève peut être supprimé"""
        # Ajouter ici la logique métier (ex: vérifier s'il a des notes, etc.)
        return True
    
    def desactiver(self):
        """Désactive l'élève au lieu de le supprimer"""
        self.actif = False
        self.save(update_fields=['actif', 'updated_at'])
    
    def __str__(self):
        return f"{self.nom_complet} ({self.matricule})"
    
    class Meta:
        verbose_name = "Élève"
        verbose_name_plural = "Élèves"
        ordering = ['nom', 'prenoms']
        indexes = [
            models.Index(fields=['matricule']),
            models.Index(fields=['nom', 'prenoms']),
            models.Index(fields=['classe', 'actif']),
            models.Index(fields=['created_at']),
        ]
        constraints = [
            models.CheckConstraint(
                check=models.Q(date_naissance__lte=timezone.now().date()),
                name='date_naissance_valide'
            )
        ]

class Enseignement(models.Model):
    """Relation Many-to-Many entre Enseignant, Classe et Matière"""
    enseignant = models.ForeignKey(CustomUser, on_delete=models.CASCADE, limit_choices_to={'user_type': 'teacher'})
    classe = models.ForeignKey(Classe, on_delete=models.CASCADE)
    matiere = models.ForeignKey(Matiere, on_delete=models.CASCADE)
    annee_scolaire = models.CharField(max_length=9, default='2024-2025')

    def __str__(self):
        return f"{self.enseignant} - {self.matiere} - {self.classe}"

    class Meta:
        unique_together = ['enseignant', 'classe', 'matiere', 'annee_scolaire']
        verbose_name = "Enseignement"
        verbose_name_plural = "Enseignements"

class Seance(models.Model):
    enseignement = models.ForeignKey(Enseignement, on_delete=models.CASCADE)
    date = models.DateField(default=timezone.now)
    heure_debut = models.TimeField()
    heure_fin = models.TimeField()
    description = models.TextField(blank=True)
    appel_fait = models.BooleanField(default=False)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.enseignement} - {self.date} {self.heure_debut}"

    class Meta:
        verbose_name = "Séance"
        verbose_name_plural = "Séances"
        ordering = ['-date', '-heure_debut']

class Presence(models.Model):
    STATUT_CHOICES = [
        ('present', 'Présent'),
        ('absent', 'Absent'),
        ('retard', 'En retard'),
    ]
    
    seance = models.ForeignKey(Seance, on_delete=models.CASCADE, related_name='presences')
    eleve = models.ForeignKey(Eleve, on_delete=models.CASCADE)
    statut = models.CharField(max_length=10, choices=STATUT_CHOICES, default='present')
    remarque = models.TextField(blank=True)
    sms_envoye = models.BooleanField(default=False)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.eleve} - {self.seance} - {self.get_statut_display()}"

    class Meta:
        unique_together = ['seance', 'eleve']
        verbose_name = "Présence"
        verbose_name_plural = "Présences"

class Note(models.Model):
    TYPE_CHOICES = [
        ('devoir', 'Devoir'),
        ('composition', 'Composition'),
        ('interrogation', 'Interrogation'),
        ('projet', 'Projet'),
    ]
    
    eleve = models.ForeignKey(Eleve, on_delete=models.CASCADE, related_name='notes')
    enseignement = models.ForeignKey(Enseignement, on_delete=models.CASCADE)
    type_note = models.CharField(max_length=15, choices=TYPE_CHOICES)
    valeur = models.DecimalField(max_digits=4, decimal_places=2)
    note_sur = models.DecimalField(max_digits=4, decimal_places=2, default=20)
    date_evaluation = models.DateField(default=timezone.now)
    description = models.CharField(max_length=200, blank=True)
    sms_envoye = models.BooleanField(default=False)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.eleve} - {self.enseignement.matiere} - {self.valeur}/{self.note_sur}"

    @property
    def note_sur_20(self):
        """Convertit la note sur 20"""
        return (self.valeur / self.note_sur) * 20

    class Meta:
        verbose_name = "Note"
        verbose_name_plural = "Notes"
        ordering = ['-date_evaluation']

class SMSLog(models.Model):
    STATUT_CHOICES = [
        ('envoye', 'Envoyé'),
        ('erreur', 'Erreur'),
        ('en_attente', 'En attente'),
    ]
    
    destinataire = models.CharField(max_length=15)
    message = models.TextField()
    statut = models.CharField(max_length=10, choices=STATUT_CHOICES, default='en_attente')
    type_message = models.CharField(max_length=20)  # 'absence' ou 'note'
    reference_id = models.CharField(max_length=50, blank=True)  # ID de la présence ou note
    erreur_detail = models.TextField(blank=True)
    created_at = models.DateTimeField(auto_now_add=True)
    sent_at = models.DateTimeField(null=True, blank=True)

    def __str__(self):
        return f"SMS {self.type_message} - {self.destinataire} - {self.get_statut_display()}"

    class Meta:
        verbose_name = "Log SMS"
        verbose_name_plural = "Logs SMS"
        ordering = ['-created_at']