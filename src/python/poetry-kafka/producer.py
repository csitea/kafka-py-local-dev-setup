# Create a Kafka producer instance
import json
import string
import random

from kafka import KafkaProducer

producer = KafkaProducer(
    bootstrap_servers='127.0.0.1:9092',
    value_serializer=lambda m: json.dumps(m).encode('utf-8')
)
# generating random strings
random_string = ''.join(random.choices(string.ascii_lowercase + string.digits, k=10))

producer.send('new', value={"Random string": random_string})

# Send all new messages to the broker
producer.flush()
