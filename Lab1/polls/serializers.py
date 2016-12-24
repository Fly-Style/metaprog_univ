from rest_framework import serializers

from polls.models import Client, Riding, Bookmaker
from rest_framework import serializers

class RidingSerializer(serializers.ModelSerializer):
    class Meta:
        model = Riding
        fields = ('name', 'firstHorseChance', 'secondHorseChance', 'winner', 'visible')


class ClientSerializer(serializers.ModelSerializer):
    class Meta:
        model = Client
        fields = ('id', 'name', 'password', 'email', 'balance', 'logged')

class BookmakerSerializer(serializers.ModelSerializer):
    class Meta:
        model = Bookmaker
        fields = ('id', 'name', 'password', 'email', 'balance', 'logged')




class JWTSerializer(serializers.Serializer):
    """
    Serializer for JWT authentication.
    """
    token = serializers.CharField()
    user = ClientSerializer()