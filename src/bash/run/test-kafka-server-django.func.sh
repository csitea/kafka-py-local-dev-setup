do_test_kafka_server_django(){

    cd ./src/python/kafka-django-test

    python3 -m venv ./venv

    source ./venv/bin/activate

    python -m ensurepip --upgrade

    pip install -r requirements.txt

    echo "Starting Django server at http://127.0.0.1:8000"

    python manage.py runserver


}