#!/bin/bash
set -x;
# Start the first process
/bin/bash $KAFKA_HOME/bin/zookeeper-server-start.sh $KAFKA_HOME/config/zookeeper.properties &

echo "advertised.listeners=PLAINTEXT://127.0.0.1:9092" >> $KAFKA_HOME/config/server.properties

# Start the second process
/bin/bash $KAFKA_HOME/bin/kafka-server-start.sh $KAFKA_HOME/config/server.properties

# echo "zookeeper started"

# Wait for any process to exit
# wait -n

# Exit with status of process that exited first
# exit $?

trap : TERM INT; sleep infinity & wait