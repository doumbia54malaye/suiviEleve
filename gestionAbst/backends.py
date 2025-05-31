# backends.py (créez ce fichier dans votre app)
from django.contrib.auth.backends import ModelBackend
from django.contrib.auth import get_user_model

User = get_user_model()

class EmailBackend(ModelBackend):
    """
    Backend d'authentification qui permet la connexion avec l'email au lieu du nom d'utilisateur
    """
    def authenticate(self, request, username=None, password=None, **kwargs):
        try:
            # Chercher l'utilisateur par email
            user = User.objects.get(email=username)
            
            # Vérifier le mot de passe
            if user.check_password(password) and self.user_can_authenticate(user):
                return user
        except User.DoesNotExist:
            # Exécuter le hashage par défaut pour éviter les attaques de timing
            User().set_password(password)
            return None
        
        return None
    
    def get_user(self, user_id):
        try:
            return User.objects.get(pk=user_id)
        except User.DoesNotExist:
            return None