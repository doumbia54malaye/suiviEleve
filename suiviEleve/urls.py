
from django.contrib import admin
from django.urls import path,include
import gestionAbst
from gestionAbst import views as gestion_abst_views

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', include(('gestionAbst.urls','gestionAbst'), namespace='gestionAbst')),
   path('', gestion_abst_views.index, name='index'),
]

