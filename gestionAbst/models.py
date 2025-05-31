# ===== MODELS.PY =====
from django.db import models
from django.contrib.auth.models import AbstractUser
from django.core.validators import RegexValidator
from django.utils import timezone

class CustomUser(AbstractUser):
    USER_TYPE_CHOICES = [
        ('admin', 'Administrateur'),
        ('teacher', 'Enseignant'),
        ('parent', 'Parent'),  # Ajouté pour correspondre à votre formulaire
    ]
    
    user_type = models.CharField(
        max_length=10, 
        choices=USER_TYPE_CHOICES, 
        default='teacher',
        verbose_name="Type d'utilisateur"
    )
    
    phone_regex = RegexValidator(
        regex=r'^\+?1?\d{8,15}$',
        message="Le numéro de téléphone doit être au format: '+225XXXXXXXX'."
    )
    phone_number = models.CharField(
        validators=[phone_regex], 
        max_length=17, 
        blank=True,
        verbose_name="Téléphone"
    )
    
    # Correction des conflits de related_name
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
class Classe(models.Model):
    nom = models.CharField(max_length=50, unique=True)
    niveau = models.CharField(max_length=20)
    description = models.TextField(blank=True)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.nom} - {self.niveau}"

    class Meta:
        verbose_name = "Classe"
        verbose_name_plural = "Classes"

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

class Eleve(models.Model):
    nom = models.CharField(max_length=50)
    prenoms = models.CharField(max_length=100)
    date_naissance = models.DateField()
    matricule = models.CharField(max_length=20, unique=True)
    classe = models.ForeignKey(Classe, on_delete=models.CASCADE, related_name='eleves')
    
    # Informations des parents
    nom_parent = models.CharField(max_length=100)
    phone_regex = RegexValidator(
        regex=r'^\+?225?\d{8,10}$',
        message="Le numéro doit être au format: '+225XXXXXXXX' ou '0XXXXXXXX'."
    )
    telephone_parent = models.CharField(validators=[phone_regex], max_length=15)
    email_parent = models.EmailField(blank=True)
    
    actif = models.BooleanField(default=True)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.nom} {self.prenoms} ({self.matricule})"

    @property
    def nom_complet(self):
        return f"{self.nom} {self.prenoms}"

    class Meta:
        verbose_name = "Élève"
        verbose_name_plural = "Élèves"
        ordering = ['nom', 'prenoms']

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