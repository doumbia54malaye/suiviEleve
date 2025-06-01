from django import forms
from django.core.exceptions import ValidationError
from .models import Eleve, Classe
import datetime

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
                'placeholder': 'Nom de famille'
            }),
            'prenoms': forms.TextInput(attrs={
                'class': 'form-control',
                'placeholder': 'Prénoms'
            }),
            'date_naissance': forms.DateInput(attrs={
                'class': 'form-control',
                'type': 'date'
            }),
            'matricule': forms.TextInput(attrs={
                'class': 'form-control',
                'placeholder': 'Matricule unique'
            }),
            'classe': forms.Select(attrs={
                'class': 'form-control'
            }),
            'nom_parent': forms.TextInput(attrs={
                'class': 'form-control',
                'placeholder': 'Nom du parent/tuteur'
            }),
            'telephone_parent': forms.TextInput(attrs={
                'class': 'form-control',
                'placeholder': '+225XXXXXXXX ou 0XXXXXXXX'
            }),
            'email_parent': forms.EmailInput(attrs={
                'class': 'form-control',
                'placeholder': 'email@exemple.com (optionnel)'
            }),
            'actif': forms.CheckboxInput(attrs={
                'class': 'form-check-input'
            })
        }
        labels = {
            'nom': 'Nom de famille',
            'prenoms': 'Prénoms',
            'date_naissance': 'Date de naissance',
            'matricule': 'Matricule',
            'classe': 'Classe',
            'nom_parent': 'Nom du parent/tuteur',
            'telephone_parent': 'Téléphone du parent',
            'email_parent': 'Email du parent (optionnel)',
            'actif': 'Élève actif'
        }

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        # Rendre certains champs obligatoires
        self.fields['nom'].required = True
        self.fields['prenoms'].required = True
        self.fields['date_naissance'].required = True
        self.fields['matricule'].required = True
        self.fields['classe'].required = True
        self.fields['nom_parent'].required = True
        self.fields['telephone_parent'].required = True
        
        # Charger les classes disponibles
        self.fields['classe'].queryset = Classe.objects.all()
        self.fields['classe'].empty_label = "Sélectionner une classe"

    def clean_date_naissance(self):
        date_naissance = self.cleaned_data.get('date_naissance')
        if date_naissance:
            today = datetime.date.today()
            age = today.year - date_naissance.year - ((today.month, today.day) < (date_naissance.month, date_naissance.day))
            
            # Vérifier que l'âge est raisonnable (entre 3 et 25 ans)
            if age < 3:
                raise ValidationError("L'élève doit avoir au moins 3 ans.")
            if age > 25:
                raise ValidationError("L'âge de l'élève semble incorrect.")
            
            # Vérifier que la date n'est pas dans le futur
            if date_naissance > today:
                raise ValidationError("La date de naissance ne peut pas être dans le futur.")
        
        return date_naissance

    def clean_matricule(self):
        matricule = self.cleaned_data.get('matricule')
        if matricule:
            # Vérifier l'unicité du matricule
            if self.instance.pk:
                # En mode édition, exclure l'instance actuelle
                if Eleve.objects.filter(matricule=matricule).exclude(pk=self.instance.pk).exists():
                    raise ValidationError("Ce matricule existe déjà.")
            else:
                # En mode création
                if Eleve.objects.filter(matricule=matricule).exists():
                    raise ValidationError("Ce matricule existe déjà.")
        
        return matricule

    def clean_nom(self):
        nom = self.cleaned_data.get('nom')
        if nom:
            # Supprimer les espaces en début/fin et convertir en titre
            nom = nom.strip().title()
            if len(nom) < 2:
                raise ValidationError("Le nom doit contenir au moins 2 caractères.")
        return nom

    def clean_prenoms(self):
        prenoms = self.cleaned_data.get('prenoms')
        if prenoms:
            # Supprimer les espaces en début/fin et convertir en titre
            prenoms = prenoms.strip().title()
            if len(prenoms) < 2:
                raise ValidationError("Les prénoms doivent contenir au moins 2 caractères.")
        return prenoms