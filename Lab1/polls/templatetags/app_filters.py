# Created by flystyle on 09.12.16. All rights reserved. ©


from django import template
from datetime import date, timedelta
from django.template.defaultfilters import stringfilter

register = template.Library()


@register.filter(name='toUpper')
@stringfilter
def toUpper(val):
    return val.upper()
