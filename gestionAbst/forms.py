from django import forms
from .models import Eleve

class EleveForm(forms.ModelForm):
    class Meta:
        model = Eleve
        fields = ['nom', 'prenoms', 'matricule', 'classe', 'telephone_parent', 'actif']
