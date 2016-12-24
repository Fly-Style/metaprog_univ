from django.contrib import admin

# Register your models here.

from .models import  Bet
from .models import Riding
from .models import Client
from .models import Bookmaker

admin.site.register(Riding)
admin.site.register(Bet)
admin.site.register(Client)
admin.site.register(Bookmaker)