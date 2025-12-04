#!make

docker-staging-start: ## Launch and initialize production-like services using Docker (PostgreSQL and Redis).
docker-staging-start: docker-staging-stop docker-postgresql-start docker-redis-start
	export MAYAN_DATABASES="{'default':{'ENGINE':'django.db.backends.postgresql','NAME':'$(DEFAULT_DATABASE_NAME)','PASSWORD':'$(DEFAULT_DATABASE_PASSWORD)','USER':'$(DEFAULT_DATABASE_USER)','HOST':'127.0.0.1'}}"; \
	rm --force --recursive $(MAYAN_TEST_MEDIA_ROOT); \
	export MAYAN_MEDIA_ROOT=$(MAYAN_TEST_MEDIA_ROOT); \
	./manage.py common_initial_setup --settings=mayan.settings.staging.docker

docker-staging-stop: ## Stop and delete the Docker production-like services.
docker-staging-stop: docker-postgresql-stop docker-redis-stop

docker-staging-frontend: ## Launch a front end instance that uses the production-like services.
	export MAYAN_DATABASES="{'default':{'ENGINE':'django.db.backends.postgresql','NAME':'$(DEFAULT_DATABASE_NAME)','PASSWORD':'$(DEFAULT_DATABASE_PASSWORD)','USER':'$(DEFAULT_DATABASE_USER)','HOST':'127.0.0.1'}}"; \
	$(COMMAND_SENTRY); ./manage.py runserver --settings=mayan.settings.staging.docker

docker-staging-worker: ## Launch a worker instance that uses the production-like services.
	export MAYAN_DATABASES="{'default':{'ENGINE':'django.db.backends.postgresql','NAME':'$(DEFAULT_DATABASE_NAME)','PASSWORD':'$(DEFAULT_DATABASE_PASSWORD)','USER':'$(DEFAULT_DATABASE_USER)','HOST':'127.0.0.1'}}"; \
	DJANGO_SETTINGS_MODULE=mayan.settings.staging.docker celery -A mayan worker -B -l INFO -O fair
