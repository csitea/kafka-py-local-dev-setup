do_test_kafka_server_django(){

    cd ./src/python/kafka-django-test

    python3 -m venv ./venv

    source ./venv/bin/activate

    python -m ensurepip --upgrade

    pip install -r requirements.txt

    python manage.py runserver


}