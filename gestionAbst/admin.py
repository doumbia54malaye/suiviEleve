from django.contrib import admin
from django.contrib.auth.admin import UserAdmin
from .models import *

@admin.register(CustomUser)
class CustomUserAdmin(UserAdmin):
    fieldsets = UserAdmin.fieldsets + (
        ('Informations supplémentaires', {'fields': ('user_type', 'phone_number')}),
    )
    add_fieldsets = UserAdmin.add_fieldsets + (
        ('Informations supplémentaires', {'fields': ('user_type', 'phone_number')}),
    )
    list_display = ['username', 'first_name', 'last_name', 'user_type', 'phone_number', 'is_active']
    list_filter = ['user_type', 'is_active', 'is_staff']

@admin.register(Classe)
class ClasseAdmin(admin.ModelAdmin):
    list_display = ['nom', 'niveau', 'created_at']
    search_fields = ['nom', 'niveau']

@admin.register(Matiere)
class MatiereAdmin(admin.ModelAdmin):
    list_display = ['nom', 'code', 'coefficient']
    search_fields = ['nom', 'code']

@admin.register(Eleve)
class EleveAdmin(admin.ModelAdmin):
    list_display = ['nom', 'prenoms', 'matricule', 'classe', 'telephone_parent', 'actif']
    list_filter = ['classe', 'actif']
    search_fields = ['nom', 'prenoms', 'matricule']
    readonly_fields = ['created_at']

@admin.register(Enseignement)
class EnseignementAdmin(admin.ModelAdmin):
    list_display = ['enseignant', 'matiere', 'classe', 'annee_scolaire']
    list_filter = ['annee_scolaire', 'matiere', 'classe']

@admin.register(Seance)
class SeanceAdmin(admin.ModelAdmin):
    list_display = ['enseignement', 'date', 'heure_debut', 'heure_fin', 'appel_fait']
    list_filter = ['date', 'appel_fait']
    date_hierarchy = 'date'

class PresenceInline(admin.TabularInline):
    model = Presence
    extra = 0

@admin.register(Presence)
class PresenceAdmin(admin.ModelAdmin):
    list_display = ['eleve', 'seance', 'statut', 'sms_envoye']
    list_filter = ['statut', 'sms_envoye', 'seance__date']

@admin.register(Note)
class NoteAdmin(admin.ModelAdmin):
    list_display = ['eleve', 'enseignement', 'type_note', 'valeur', 'note_sur', 'date_evaluation', 'sms_envoye']
    list_filter = ['type_note', 'sms_envoye', 'date_evaluation', 'enseignement__matiere']

@admin.register(SMSLog)
class SMSLogAdmin(admin.ModelAdmin):
    list_display = ['destinataire', 'type_message', 'statut', 'created_at', 'sent_at']
    list_filter = ['statut', 'type_message', 'created_at']
    search_fields = ['destinataire', 'message', 'reference_id']
    readonly_fields = ['created_at', 'sent_at']
    
    fieldsets = (
        ('Informations SMS', {
            'fields': ('destinataire', 'message', 'type_message', 'reference_id')
        }),
        ('Statut', {
            'fields': ('statut', 'erreur_detail')
        }),
        ('Horodatage', {
            'fields': ('created_at', 'sent_at'),
            'classes': ('collapse',)
        }),
    )
    
    def has_add_permission(self, request):
        # Empêcher l'ajout manuel de logs SMS
        return False
    
    def has_delete_permission(self, request, obj=None):
        # Permettre la suppression pour le nettoyage
        return True
    
    actions = ['mark_as_sent', 'mark_as_error']
    
    def mark_as_sent(self, request, queryset):
        queryset.update(statut='envoye')
        self.message_user(request, f"{queryset.count()} SMS marqués comme envoyés.")
    mark_as_sent.short_description = "Marquer comme envoyés"
    
    def mark_as_error(self, request, queryset):
        queryset.update(statut='erreur')
        self.message_user(request, f"{queryset.count()} SMS marqués en erreur.")
    mark_as_error.short_description = "Marquer en erreur"