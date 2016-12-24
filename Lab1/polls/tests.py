
from django.test import TestCase
from polls.models import Riding


class AnimalTestCase(TestCase):

    # name = models.CharField(verbose_name="RideName", max_length=100, unique=1)
    # firstHorseChance = models.FloatField(verbose_name="RideFirstHorseChance", null=True)  # NULL at the begin
    # secondHorseChance = models.FloatField(verbose_name="RideSecondHorseChance", null=True)  # NULL at the begin
    # winner = models.IntegerField(verbose_name="RideWinner", null=True)  # NULL at the begin
    # visible = models.NullBooleanField(verbose_name="RideVisible", null=True, default=False)
    # ready = models.BooleanField(verbose_name="RidePrognosed", default=False)

    def setUp(self):
        Riding.objects.create(name="aaa", firstHorseChance=1.5, secondHorseChance=1.5, winner=1)
        Riding.objects.create(name="bbb", firstHorseChance=1.5, secondHorseChance=1.5, winner=2)

    def test_animals_can_speak(self):
        """Animals that can speak are correctly identified"""
        a = Riding.objects.get(name="aaa")
        b = Riding.objects.get(name="bbb")
        self.assertEqual(a.winner, 1)
        self.assertEqual(b.firstHorseChance, 1.5)