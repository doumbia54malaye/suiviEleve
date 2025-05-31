# ===== SERVICES/SMS_SERVICE.PY =====
import requests
import json
from django.conf import settings
from django.utils import timezone
from .models import SMSLog
import logging

logger = logging.getLogger(__name__)

class OrangeSMSService:
    def __init__(self):
        self.config = settings.ORANGE_SMS_CONFIG
        self.access_token = None
    
    def get_access_token(self):
        """Obtient le token d'accès Orange CI"""
        try:
            auth_url = "https://api.orange.com/oauth/v2/token"
            
            headers = {
                'Authorization': f'Basic {self._get_basic_auth()}',
                'Content-Type': 'application/x-www-form-urlencoded',
            }
            
            data = {
                'grant_type': 'client_credentials'
            }
            
            response = requests.post(auth_url, headers=headers, data=data)
            
            if response.status_code == 200:
                token_data = response.json()
                self.access_token = token_data['access_token']
                return True
            else:
                logger.error(f"Erreur authentification Orange: {response.text}")
                return False
                
        except Exception as e:
            logger.error(f"Erreur lors de l'authentification: {str(e)}")
            return False
    
    def _get_basic_auth(self):
        """Génère l'authentification Basic pour Orange"""
        import base64
        credentials = f"{self.config['CLIENT_ID']}:{self.config['CLIENT_SECRET']}"
        return base64.b64encode(credentials.encode()).decode()
    
    def send_sms(self, phone_number, message, message_type, reference_id=None):
        """Envoie un SMS via l'API Orange CI"""
        
        # Créer le log SMS
        sms_log = SMSLog.objects.create(
            destinataire=phone_number,
            message=message,
            type_message=message_type,
            reference_id=reference_id or '',
            statut='en_attente'
        )
        
        try:
            # Obtenir le token d'accès
            if not self.access_token:
                if not self.get_access_token():
                    sms_log.statut = 'erreur'
                    sms_log.erreur_detail = 'Impossible d\'obtenir le token d\'accès'
                    sms_log.save()
                    return False
            
            # Formatage du numéro (Orange CI utilise le format international)
            if phone_number.startswith('0'):
                phone_number = '+225' + phone_number[1:]
            elif not phone_number.startswith('+'):
                phone_number = '+225' + phone_number
            
            # Préparer la requête SMS
            sms_url = f"{self.config['BASE_URL']}/outbound/{self.config['SENDER_ADDRESS'].replace('tel:', '')}/requests"
            
            headers = {
                'Authorization': f'Bearer {self.access_token}',
                'Content-Type': 'application/json',
            }
            
            payload = {
                "outboundSMSMessageRequest": {
                    "address": f"tel:{phone_number}",
                    "senderAddress": self.config['SENDER_ADDRESS'],
                    "outboundSMSTextMessage": {
                        "message": message
                    }
                }
            }
            
            response = requests.post(sms_url, headers=headers, json=payload)
            
            if response.status_code in [200, 201]:
                sms_log.statut = 'envoye'
                sms_log.sent_at = timezone.now()
                sms_log.save()
                logger.info(f"SMS envoyé avec succès à {phone_number}")
                return True
            else:
                sms_log.statut = 'erreur'
                sms_log.erreur_detail = f"Erreur HTTP {response.status_code}: {response.text}"
                sms_log.save()
                logger.error(f"Erreur envoi SMS: {response.text}")
                return False
                
        except Exception as e:
            sms_log.statut = 'erreur'
            sms_log.erreur_detail = str(e)
            sms_log.save()
            logger.error(f"Exception lors de l'envoi SMS: {str(e)}")
            return False
    
    def send_absence_sms(self, presence):
        """Envoie un SMS pour une absence"""
        eleve = presence.eleve
        seance = presence.seance
        
        message = f"""Bonjour {eleve.nom_parent},
        
Votre enfant {eleve.nom_complet} a été marqué(e) ABSENT(E) le {seance.date.strftime('%d/%m/%Y')} de {seance.heure_debut} à {seance.heure_fin} en {seance.enseignement.matiere.nom} avec {seance.enseignement.enseignant.get_full_name()}.

École - Système de gestion"""
        
        return self.send_sms(
            eleve.telephone_parent,
            message,
            'absence',
            f'presence_{presence.id}'
        )
    
    def send_grade_sms(self, note):
        """Envoie un SMS pour une nouvelle note"""
        eleve = note.eleve
        
        message = f"""Bonjour {eleve.nom_parent},

Nouvelle note pour {eleve.nom_complet}:
- Matière: {note.enseignement.matiere.nom}
- Type: {note.get_type_note_display()}
- Note: {note.valeur}/{note.note_sur} ({note.note_sur_20:.1f}/20)
- Date: {note.date_evaluation.strftime('%d/%m/%Y')}

École - Système de gestion"""
        
        return self.send_sms(
            eleve.telephone_parent,
            message,
            'note',
            f'note_{note.id}'
        )

# Instance globale du service SMS
sms_service = OrangeSMSService()
