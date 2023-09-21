# kafka-py-local-dev-setup
A dockerized local-dev setup for kafka-server environment and python connection to it. 

## USAGE 
Run the following command to build the docker img and spawn the kafka-server container:
```bash
make clean-install-kafka-server
```

You can use the included django project to test the connection to the kafka-server and add topics and events.
To start the django server locally run the following command:

```bash
./run -a do_test_kafka_server_django
```

Open the app at http://127.0.0.1:8000 in your browser.
