from django.urls import path

from DjangoKafka.kafka.views import index

urlpatterns = [
    path('', index, name='index-page'),
]