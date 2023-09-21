import json

from django.shortcuts import render
from kafka import KafkaConsumer, KafkaProducer

from DjangoKafka.kafka.forms import TheForm
from DjangoKafka.kafka.helper_func import helper_func

helper = helper_func()
# Create your views here.
def index(request):
    form = TheForm()
    # Create a Kafka producer instance
    if helper():
        producer = KafkaProducer(
            bootstrap_servers='127.0.0.1:9092',
            value_serializer=lambda m: json.dumps(m).encode('utf-8')
        )

        producer.send('new', value={"name": "test", 'age': 92})

        # Send all new messages to the broker
        producer.flush()

    if request.method == "POST":
        form = TheForm(request.POST)
        if form.is_valid():

            new_producer = KafkaProducer(
                bootstrap_servers='127.0.0.1:9092',
                value_serializer=lambda m: json.dumps(m).encode('utf-8')
            )
            print(form.cleaned_data)
            the_topic = form.cleaned_data['topic']
            new_producer.send(topic=the_topic, value=form.cleaned_data)

            # Send all new messages to the broker
            new_producer.flush()
            consumer = KafkaConsumer(
                bootstrap_servers='127.0.0.1:9092',
                auto_offset_reset='earliest',  # Set to 'earliest' to read all messages from the beginning
                enable_auto_commit=True,
                auto_commit_interval_ms=1000,
                consumer_timeout_ms=1000,
                value_deserializer=lambda m: json.loads(m.decode('utf-8'))
            )
            consumer.subscribe([the_topic])
            new_form = TheForm()
            context = {
                'consumer': consumer,
                'form': new_form,
            }
            return render(request, 'index.html', context=context)
    consumer = KafkaConsumer(
        bootstrap_servers='127.0.0.1:9092',
        auto_offset_reset='earliest',  # Set to 'earliest' to read all messages from the beginning
        enable_auto_commit=True,
        auto_commit_interval_ms=1000,
        consumer_timeout_ms=1000,
        value_deserializer=lambda m: json.loads(m.decode('utf-8'))
    )
    consumer.subscribe(['new'])
    context ={
        "form": form,
        'consumer': consumer,
    }
    return render(request, 'index.html', context=context)
