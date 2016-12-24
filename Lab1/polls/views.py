import json

from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.models import User
from django.http import Http404
from django.shortcuts import render
from django.http import HttpResponse
import logging

# Create your views here.
from django.template import RequestContext
from django.template import loader
from django.views.decorators.csrf import ensure_csrf_cookie

from polls.models import Riding, Client, Bookmaker, Bet, BetToRide  # Bet


def root(request):
    return HttpResponse(render(request, 'polls/login.html'))


def index(request):
    latest_ride_list = Riding.objects.exclude(visible=False).order_by('-id')
    try:
        client = Client.objects.get(username=request.session['usr'])
        print(client)
    except Client.DoesNotExist:
        raise Http404

    template = loader.get_template('polls/index.html')
    context = RequestContext(request, {
        'latest_ride_list': latest_ride_list,
        'client': client,
    })
    return HttpResponse(template.render(context))


def register_page(request):
    return render(request, 'polls/register.html')


@ensure_csrf_cookie
def login_(request):
    print(request.POST['login'])
    global isBookmaker
    logging.basicConfig(level=logging.DEBUG)
    log = logging.getLogger(None)
    username = request.POST['login']
    password = request.POST['password']
    user = authenticate(username=username, password=password)

    if user is None:
        t = loader.get_template('polls/fail.html')
        reqContext = ({
            "username": username,
        })
        print(username)
        return HttpResponse(t.render(reqContext))
    else:
        login(request, user)
        calledUser = User.objects.get(username=username)
        if calledUser.is_superuser:
            log.info('Admin ' + calledUser.username + ' logged in')
            # SystemLog(calledUser)
            client = Client.objects.get(username=calledUser.username)
            context = ({
                'client': client
            })
            request.session['usr'] = client.username
            return render(request, 'polls/adminpage.html', context=context)

        else:

            try:
                maybeBookmaker = Client.objects.get(username=calledUser.username)
                try:
                    isBookmaker = Bookmaker.objects.get(id=maybeBookmaker.id)
                except Bookmaker.DoesNotExist:
                    isBookmaker = None
            except Client.DoesNotExist:
                maybeBookmaker = None

            try:
                isClient = Client.objects.get(username=calledUser.username)
            except Client.DoesNotExist:
                isClient = None

            if isBookmaker is not None:
                # SystemLog(calledUser)
                log.info('Bookmaker ' + maybeBookmaker.username + ' logged in')
                maybeBookmaker.logged = True
                request.session['usr'] = maybeBookmaker.username
                return HttpResponse(render(request, 'polls/startpage.html', context={'client': maybeBookmaker}))

            elif isClient is not None:
                # SystemLog(calledUser)
                log.info('Client ' + isClient.username + ' logged in')
                context = ({'client': isClient})
                isClient.logged = True
                request.session['usr'] = isClient.username
                return HttpResponse(render(request, 'polls/startpage.html', context))

            else:
                log.info('Unknown user tried to logged in')
                t = loader.get_template('polls/fail.html')
                reqContext = ({
                    "username": username,
                })
                return HttpResponse(t.render(reqContext))


def logout_(request):
    logging.basicConfig(level=logging.DEBUG)
    log = logging.getLogger(None)
    log.info(request.session['usr'] + "-> logged out")
    request.session['usr'] = None
    logout(request)
    return HttpResponse(render(request, 'polls/login.html'))


def register(request):
    user = User.objects.create_user(username=request.POST['login'], password=request.POST['password'])
    user.save()
    count = Client.objects.count()
    print(count)
    client = Client(id=count+1, name_id=user.id, username=user.username, password=user.password,
                    email=request.POST['email'], balance=1000, logged=False)
    client.save()
    return HttpResponse(render(request, 'polls/login.html'))


def startPage(request):
    if request.method == 'GET':
        username = request.session['usr']
        try:
            superuser = User.objects.get(username=username)
        except User.DoesNotExist:
            superuser = None

        if superuser.is_superuser:
            client = Client.objects.get(username=username)
            context = ({'client': client})
            request.session['usr'] = username
            return render(request, 'polls/adminpage.html', context=context)
        else:
            client = Client.objects.get(username=username)
            context = ({'client': client})
            return render(request, 'polls/startpage.html', context=context)


def failPage(request):
    if request.method == 'GET':
        if request.session['usr'] is not None:
            context = ({'username': request.session['usr']})
            return render(request, 'polls/fail.html', context=context)
        else:
            return render(request, 'polls/fail.html')


def betController(request):
    if request.method == 'POST':
        strn = request.body.decode("utf-8")
        data = json.loads(strn)

        moneyValue = data['expressValue']
        potentialWin = data['potentialWin']
        ridesIdArray = data['ridesIdArray']
        owner_name = data['user_name']

        ownerLink = Client.objects.get(username=owner_name)
        ownerLink.balance -= moneyValue
        ownerLink.save()
        bet = Bet(value=moneyValue, potentialWin=potentialWin, isBetSuccessful=False, isActive=True,
                  ownerLink=ownerLink)
        bet.save()
        for bet_info in ridesIdArray:
            data_ = json.loads(bet_info)
            ride_id = data_['ride_id']
            bet_winner = data_['bet_winner']
            ride = Riding.objects.get(id=ride_id)

            bet_to_ride = BetToRide(ride_id=ride, bet_id=bet, ride_bet_winner=bet_winner)
            bet_to_ride.save()

    return HttpResponse("<h1>Kek</h1>")


def predictionController(request):
    if request.method == 'POST':
        dataStr = request.body.decode('utf-8')
        data = json.loads(dataStr)
        print(data)

        first_chance = float(data['first'])
        second_chance = float(data['second'])
        ride_id = int(data['ride_id'])

        Bookmaker.setChances(ride_id, first_chance, second_chance)

        return HttpResponse("<h1>Kek</h1>")


def finishBetController(request):
    dataMsg = request.body.decode('utf-8')
    data = json.loads(dataMsg)
    end_arr = data['arr']
    for race_info in end_arr:
        data_ = json.loads(race_info)
        bet_winner = data_['winner']
        ride_id = data_['race_id']
        BetToRide.endRace(ride_id, bet_winner)
    return HttpResponse("<h1>Kek</h1>")


def cleintpage(request):
    if request.session['usr'] is not None:
        clientname = request.session['usr']
        print("clientname : " + clientname)
        user = Client.objects.get(username=clientname)
        template = loader.get_template('polls/clientpage.html')
        context = RequestContext(request, {
            'client': user,
        })

        return HttpResponse(template.render(context))
    else:
        return render(request, '404.html')


def bookmaker(request):
    client = Client.objects.get(username=request.session['usr'])
    client_id = client.id

    try:
        checker = Bookmaker.objects.get(client_ptr_id=client_id)
    except Bookmaker.DoesNotExist:
        checker = None

    if checker is None:
        context = ({'client': client})
        return render(request, 'polls/startpage.html', context)
    else:
        latest_ride_list = Riding.objects.exclude(ready=True).order_by('-id')
        template = loader.get_template('polls/bookmakerpage.html')
        context = RequestContext(request, {
            'latest_ride_list': latest_ride_list,
            'client': client,
        })
        return HttpResponse(template.render(context))


def adminPage(request):
    if request.method == 'GET':
        try:
            print(request.session['usr'])
            username = request.session['usr']
            client = Client.objects.get(username=username)
            try:
                checker = User.objects.get(username=username)
            except User.DoesNotExist:
                checker = None
                context = ({'client': client})
                return render(request, 'polls/fail.html', context=context)

            if checker.is_superuser:
                context = ({'client': client})
                return render(request, 'polls/adminpage.html', context=context)
            else:
                context = ({'client': client})
                return render(request, 'polls/startpage.html', context=context)
        except KeyError:
            return render(request, '404.html')


def betsActions(request):
    username = request.session['usr']
    user_ = Client.objects.get(username=username)
    context = ({'client': user_})
    try:
        user = User.objects.get(username=username)
        if user.is_superuser:
            latest_ride_list = Riding.objects.exclude(visible=False).order_by('-id')
            extended_context = ({
                'client': user_,
                'latest_ride_list': latest_ride_list
            })
            return render(request, 'polls/endrace.html', extended_context)
        else:
            return render(request, 'polls/startpage.html', context=context)
    except User.DoesNotExist:
        user = None

    return render(request, 'polls/startpage.html', context=context)
