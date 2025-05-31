from django.db.models.signals import post_save
from django.dispatch import receiver
from .models import Presence, Note
from .sms_service import sms_service

@receiver(post_save, sender=Presence)
def handle_presence_change(sender, instance, created, **kwargs):
    """Signal déclenché lors de la création/modification d'une présence"""
    if instance.statut == 'absent' and not instance.sms_envoye:
        # Envoyer SMS d'absence
        if sms_service.send_absence_sms(instance):
            instance.sms_envoye = True
            instance.save(update_fields=['sms_envoye'])

@receiver(post_save, sender=Note)
def handle_new_grade(sender, instance, created, **kwargs):
    """Signal déclenché lors de la création d'une nouvelle note"""
    if created and not instance.sms_envoye:
        # Envoyer SMS de nouvelle note
        if sms_service.send_grade_sms(instance):
            instance.sms_envoye = True
            instance.save(update_fields=['sms_envoye'])
