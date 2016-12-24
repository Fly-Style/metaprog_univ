from django.conf.urls import url

from . import views
urlpatterns = [
    url(r'^betpage/$', views.index, name='index'),
    # ex: /polls/5/
    # url(r'^(?P<ride_id>[0-9]+)/$', views.results, name='results'),
    url(r'^$', views.root, name='init'),
    url(r'^register/$', views.register, name='register'),
    url(r'^login/$', views.login_, name='login'),
    url(r'^logout/$', views.logout_, name='logout'),
    url(r'^fail/$', views.failPage, name='fail'),
    url(r'^startpage/$', views.startPage, name='start'),
    url(r'^registerpage/$', views.register_page, name='registerPage'),
    url(r'^bookmaker/$', views.bookmaker, name='bookmaker_page'),
    url(r'^betsactions/$', views.betsActions, name='betscations'),
    url(r'^admin/$', views.adminPage, name='bookmaker_page'),
    url(r'^makebet$', views.betController, name='makeBet'),
    url(r'^prediction$', views.predictionController, name='makePredict'),
    url(r'^endrace$', views.finishBetController, name='makePredict'),

    url(r'^user/(?P<client_id>\d+)/$', views.cleintpage, name='client_url'),
    url(r'^user/(?P<client_id>\d+)/bookmaker/$', views.bookmaker, name='bookmaker')
]

