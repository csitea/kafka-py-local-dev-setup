import json

from kafka import KafkaProducer, KafkaConsumer

# Define the Kafka broker(s) and topic
consumer = KafkaConsumer(
    bootstrap_servers='127.0.0.1:9092',
    auto_offset_reset='earliest',  # Set to 'earliest' to read all messages from the beginning
    enable_auto_commit=True,
    auto_commit_interval_ms=1000,
    value_deserializer=lambda m: json.loads(m.decode('utf-8'))
)
# Subscribe the consumer to a topic
consumer.subscribe(['new'])

# Get all messages dynamically
for message in consumer:
    print(f"{message.topic} ------ Random string: {message.value}")

