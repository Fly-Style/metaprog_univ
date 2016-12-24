from django.contrib import postgres
from django.contrib.auth.models import User
from django.db import models

# Create your models here.

from django.db import models
from django.conf import settings

from rest_framework.authtoken.models import Token as DefaultTokenModel

from polls.utils import import_callable


class Client(models.Model):
    name = models.ForeignKey(User, on_delete=models.CASCADE)
    username = models.CharField(verbose_name="ClientName", max_length=64, default="null")
    email = models.EmailField(verbose_name="ClientMail")
    password = models.CharField(verbose_name="ClientPassword", max_length=1024)
    balance = models.FloatField(verbose_name="ClientBalance")
    logged = models.NullBooleanField(verbose_name="ClientLogged")


class Riding(models.Model):
    name = models.CharField(verbose_name="RideName", max_length=100, unique=1)
    firstHorseChance = models.FloatField(verbose_name="RideFirstHorseChance", null=True)  # NULL at the begin
    secondHorseChance = models.FloatField(verbose_name="RideSecondHorseChance", null=True)  # NULL at the begin
    winner = models.IntegerField(verbose_name="RideWinner", null=True)  # NULL at the begin
    visible = models.NullBooleanField(verbose_name="RideVisible", null=True, default=False)
    ready = models.BooleanField(verbose_name="RidePrognosed", default=False)


class Bet(models.Model):
    value = models.FloatField(verbose_name="BetValue")
    potentialWin = models.FloatField(verbose_name="BetWin")
    ownerLink = models.ForeignKey(Client, on_delete=models.CASCADE)
    isBetSuccessful = models.NullBooleanField(verbose_name='BetSuccess', default=None)
    isActive = models.NullBooleanField(verbose_name='BetActive', default=True)

    @staticmethod
    def winning_pay(client_id, prize):
        client = Client.objects.get(id=client_id)
        print("==> " + str(client.balance))
        client.balance += prize
        client.save()
        print("==> " + str(client.balance))

    @staticmethod
    def success_check(bet_id):
        try:
            bet_plural = BetToRide.objects.filter(bet_id=bet_id)
        except BetToRide.DoesNotExist:
            bet_plural = None
        print(bet_plural)

        if bet_plural is not None:
            _len = len(bet_plural)
            counter = 0
            for raw in bet_plural:
                if not raw.success:
                    bet = Bet.objects.get(id=bet_id)
                    bet.isBetSuccessful = False
                    bet.isActive = False
                    bet.save()
                    break
                elif raw.success:
                    counter += 1

                if _len == counter:
                    bet = Bet.objects.get(id=bet_id)
                    bet.isBetSuccessful = True
                    Bet.winning_pay(bet.ownerLink.id, bet.potentialWin)
                    bet.isActive = False
                    bet.save()
        else:
            return


class BetToRide(models.Model):
    ride_id = models.ForeignKey(Riding, on_delete=models.CASCADE)
    bet_id = models.ForeignKey(Bet, on_delete=models.CASCADE)
    ride_bet_winner = models.IntegerField(verbose_name='betWinner')
    success = models.NullBooleanField(verbose_name='betSucess', default=None)

    def __str__(self):
        return '({}, {})'.format(self.ride_id.name, self.bet_id.id)

    @staticmethod
    def endRace(ride_id, winner):
        ride = Riding.objects.get(id=ride_id)
        ride.winner = winner
        ride.visible = ride.ready = False
        ride.save()
        try:
            bets_to_ride = BetToRide.objects.filter(ride_id=ride_id)
        except BetToRide.DoesNotExist:
            bets_to_ride = None
        if bets_to_ride is not None:
            for raw in bets_to_ride:
                if raw.ride_bet_winner == winner:
                    raw.success = True
                else:
                    raw.success = False
                raw.save()
                Bet.success_check(raw.bet_id.id)


class Bookmaker(Client):
    @staticmethod
    def setChances(ride_id, first, second):
        ride = Riding.objects.get(id=ride_id)
        ride.firstHorseChance = first
        ride.secondHorseChance = second
        ride.visible = True
        ride.ready = True
        ride.save()


class Record(models.Model):
    username = models.ForeignKey(User)
    time = models.DateTimeField()


TokenModel = import_callable(getattr(settings, 'REST_AUTH_TOKEN_MODEL', DefaultTokenModel))
