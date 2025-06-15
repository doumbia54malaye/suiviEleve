# Créez ce fichier: management/commands/test_sms.py
# Structure: votre_app/management/commands/test_sms.py

from django.core.management.base import BaseCommand
from django.utils import timezone
from gestionAbst.services.sms_service import sms_service  
from gestionAbst.models import *

class Command(BaseCommand):
    help = 'Commande pour tester l\'envoi de SMS'

    def add_arguments(self, parser):
        parser.add_argument(
            '--phone',
            type=str,
            help='Numéro de téléphone pour le test (format: +225XXXXXXXX)',
        )
        parser.add_argument(
            '--test-auth',
            action='store_true',
            help='Tester uniquement l\'authentification Orange',
        )

    def handle(self, *args, **options):
        self.stdout.write('=== Test du service SMS Orange ===\n')
        
        if options['test_auth']:
            # Test d'authentification seulement
            self.stdout.write('Test d\'authentification...')
            if sms_service.get_access_token():
                self.stdout.write(
                    self.style.SUCCESS('✅ Authentification réussie!')
                )
                self.stdout.write(f'Token: {sms_service.access_token[:20]}...')
            else:
                self.stdout.write(
                    self.style.ERROR('❌ Échec de l\'authentification')
                )
            return

        # Test d'envoi SMS
        phone = options.get('phone')
        if not phone:
            self.stdout.write(
                self.style.ERROR('Veuillez spécifier un numéro avec --phone')
            )
            return

        # Test SMS simple
        self.stdout.write(f'Test d\'envoi SMS vers {phone}...')
        
        test_message = """Bonjour,

Ceci est un SMS de test du système de gestion scolaire.

École - Système de gestion"""

        success = sms_service.send_sms(
            phone_number=phone,
            message=test_message,
            message_type='test',
            reference_id='test_command'
        )

        if success:
            self.stdout.write(
                self.style.SUCCESS('✅ SMS de test envoyé avec succès!')
            )
        else:
            self.stdout.write(
                self.style.ERROR('❌ Échec de l\'envoi du SMS de test')
            )

        # Afficher les derniers logs

        
        self.stdout.write('\n=== Derniers logs SMS ===')
        recent_logs = SMSLog.objects.order_by('-created_at')[:5]
        
        for log in recent_logs:
            status_color = self.style.SUCCESS if log.statut == 'envoye' else self.style.ERROR
            self.stdout.write(
                f'{log.created_at.strftime("%H:%M:%S")} - '
                f'{log.destinataire} - '
                f'{status_color(log.get_statut_display())} - '
                f'{log.type_message}'
            )
            if log.erreur_detail:
                self.stdout.write(f'  Erreur: {log.erreur_detail}')

# Utilisation:
# python manage.py test_sms --test-auth
# python manage.py test_sms --phone +225XXXXXXXX