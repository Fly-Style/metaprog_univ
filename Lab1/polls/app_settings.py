from django.conf import settings

from polls.utils import import_callable, default_create_token
from polls.serializers import (
    JWTSerializer as DefaultJWTSerializer,
    ClientSerializer as DefaultUserDetailsSerializer,
)


create_token = import_callable(
    getattr(settings, 'REST_AUTH_TOKEN_CREATOR', default_create_token))

serializers = getattr(settings, 'REST_AUTH_SERIALIZERS', {})


JWTSerializer = import_callable(
    serializers.get('JWT_SERIALIZER', DefaultJWTSerializer))

UserDetailsSerializer = import_callable(
    serializers.get('USER_DETAILS_SERIALIZER', DefaultUserDetailsSerializer)
)