python ./manage.py syncdb --noinput
gunicorn_django --bind=0.0.0.0:8081
