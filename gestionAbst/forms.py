from django import forms
from django.core.exceptions import ValidationError
from .models import *
from django.contrib.auth.forms import UserCreationForm
import random
import datetime
import re
class EleveForm(forms.ModelForm):
    class Meta:
        model = Eleve
        fields = [
            'nom', 'prenoms', 'date_naissance', 'matricule', 'classe',
            'nom_parent', 'telephone_parent', 'email_parent', 'actif'
        ]
        widgets = {
            'nom': forms.TextInput(attrs={
                'class': 'form-control',
                'placeholder': 'Ex: KOUASSI'
            }),
            'prenoms': forms.TextInput(attrs={
                'class': 'form-control',
                'placeholder': 'Ex: Jean Pierre'
            }),
            'date_naissance': forms.DateInput(attrs={
                'class': 'form-control',
                'type': 'date'
            }),
            'matricule': forms.TextInput(attrs={
                'class': 'form-control',
                'placeholder': 'Sera généré automatiquement si vide'
            }),
            'classe': forms.Select(attrs={
                'class': 'form-control'
            }),
            'nom_parent': forms.TextInput(attrs={
                'class': 'form-control',
                'placeholder': 'Ex: KOUASSI Marie'
            }),
            'telephone_parent': forms.TextInput(attrs={
                'class': 'form-control',
                'placeholder': 'Ex: +225 07 XX XX XX XX'
            }),
            'email_parent': forms.EmailInput(attrs={
                'class': 'form-control',
                'placeholder': 'Ex: parent@email.com (optionnel)'
            }),
            'actif': forms.CheckboxInput(attrs={
                'class': 'form-check-input'
            })
        }
    
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        
        # Rendre le matricule optionnel (sera généré automatiquement)
        self.fields['matricule'].required = False
        
        # Personaliser les labels
        self.fields['actif'].label = "Élève actif"
        
        # Classes CSS pour la validation
        for field_name, field in self.fields.items():
            if field.required:
                field.widget.attrs['required'] = True
    
    def clean_matricule(self):
        matricule = self.cleaned_data.get('matricule')
        
        # Si pas de matricule fourni, on laisse le modèle le générer
        if not matricule:
            return matricule
        
        # CORRECTION: Utilisation de re.match() au lieu de matricule.match()
        if not re.match(r'^\d{8}[A-Z]$', matricule):
            raise ValidationError(
                "Format invalide. Le matricule doit contenir 8 chiffres "
                "suivis d'une lettre majuscule (ex: 10100891Z)."
            )
        
        # Vérification de l'unicité
        queryset = Eleve.objects.filter(matricule=matricule)
        if self.instance.pk:
            queryset = queryset.exclude(pk=self.instance.pk)
        
        if queryset.exists():
            raise ValidationError("Ce matricule existe déjà.")
        return matricule
    def clean_nom(self):
        nom = self.cleaned_data.get('nom', '').strip().upper()
        
        if not nom.replace(' ', '').replace('-', '').isalpha():
            raise ValidationError("Le nom ne doit contenir que des lettres.")
        
        return nom
    
    def clean_prenoms(self):
        prenoms = self.cleaned_data.get('prenoms', '').strip().title()
        
        if not prenoms.replace(' ', '').replace('-', '').isalpha():
            raise ValidationError("Les prénoms ne doivent contenir que des lettres.")
        
        return prenoms
    
class CustomUserCreationForm(UserCreationForm):
    USER_TYPE_CHOICES = [
        ('admin', 'Administrateur'),
        ('teacher', 'Enseignant'),
        ('parent', 'Parent'),
    ]
    
    first_name = forms.CharField(
        max_length=150,
        required=True,
        widget=forms.TextInput(attrs={'class': 'form-control'})
    )
    last_name = forms.CharField(
        max_length=150,
        required=True,
        widget=forms.TextInput(attrs={'class': 'form-control'})
    )
    email = forms.EmailField(
        required=True,
        widget=forms.EmailInput(attrs={'class': 'form-control'})
    )
    user_type = forms.ChoiceField(
        choices=USER_TYPE_CHOICES,
        required=True,
        widget=forms.Select(attrs={'class': 'form-select'})
    )
    phone_number = forms.CharField(
        max_length=20, 
        required=False,
        widget=forms.TextInput(attrs={'class': 'form-control'})
    )
    is_active = forms.BooleanField(
        required=False,
        initial=True,
        widget=forms.CheckboxInput(attrs={'class': 'form-check-input'})
    )
    is_staff = forms.BooleanField(
        required=False,
        widget=forms.CheckboxInput(attrs={'class': 'form-check-input'})
    )

    class Meta:
        model = CustomUser
        fields = ('username', 'first_name', 'last_name', 'email', 'user_type',
                  'phone_number', 'password1', 'password2', 'is_active', 'is_staff')

    def clean_email(self):
        email = self.cleaned_data.get('email')
        if email and CustomUser.objects.filter(email=email).exists():
            raise ValidationError("Cette adresse email existe déjà.")
        return email

    def clean_username(self):
        username = self.cleaned_data.get('username')
        if username and CustomUser.objects.filter(username=username).exists():
            raise ValidationError("Ce nom d'utilisateur existe déjà.")
        return username

    def clean_password1(self):
        password = self.cleaned_data.get('password1')
        if not password:
            raise ValidationError("Le mot de passe est obligatoire.")
            
        if len(password) < 8:
            raise ValidationError("Le mot de passe doit contenir au moins 8 caractères.")
                
        # Vérifier la complexité
        if not re.search(r'[A-Z]', password):
            raise ValidationError("Le mot de passe doit contenir au moins une majuscule.")
        if not re.search(r'[a-z]', password):
            raise ValidationError("Le mot de passe doit contenir au moins une minuscule.")
        if not re.search(r'\d', password):
            raise ValidationError("Le mot de passe doit contenir au moins un chiffre.")
                
        return password

    def save(self, commit=True):
        user = super().save(commit=False)
        user.email = self.cleaned_data['email']
        user.first_name = self.cleaned_data['first_name']
        user.last_name = self.cleaned_data['last_name']
        user.user_type = self.cleaned_data['user_type']
        user.phone_number = self.cleaned_data.get('phone_number', '')
        user.is_active = self.cleaned_data.get('is_active', True)
        user.is_staff = self.cleaned_data.get('is_staff', False)
        
        if commit:
            user.save()
        return user
def clean(self):
    cleaned_data = super().clean()
    # Validation croisée des champs si nécessaire
    password1 = cleaned_data.get("password1")
    password2 = cleaned_data.get("password2")

    if password1 and password2 and password1 != password2:
        raise ValidationError("Les mots de passe ne correspondent pas")
    
    return cleaned_data