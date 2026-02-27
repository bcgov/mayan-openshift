#!make

CONTAINER_TEST_ELASTICSEARCH_NAME = mayan-test-elastic
CONTAINER_TEST_MAYAN_EDMS_NAME = mayan-test
CONTAINER_TEST_MYSQL_NAME = mayan-test-mysql
CONTAINER_TEST_ORACLE_NAME = mayan-test-oracle
CONTAINER_TEST_POSTGRESQL_NAME = mayan-test-postgresql
CONTAINER_TEST_REDIS_NAME = mayan-test-redis

docker-elasticsearch-start: ## Start an Elasticsearch test container.
docker-elasticsearch-start:
	@docker run \
	--detach \
	-e ELASTIC_PASSWORD=${DEFAULT_ELASTICSEARCH_PASSWORD} \
	-e ES_JAVA_OPTS="-Xms256m -Xmx256m" \
	-e "discovery.type=single-node" \
	-e "ingest.geoip.downloader.enabled=false" \
	--name $(CONTAINER_TEST_ELASTICSEARCH_NAME) \
	--publish 9200:9200 \
	--publish 9300:9300 \
	$(DOCKER_ELASTIC_IMAGE_NAME):$(DOCKER_ELASTIC_IMAGE_TAG)
	@while ! nc -z 127.0.0.1 9200; do echo -n .; sleep 1; done

docker-elasticsearch-stop: ## Stop and delete the Elasticsearch container.
docker-elasticsearch-stop:
	@docker container rm \
	--force $(CONTAINER_TEST_ELASTICSEARCH_NAME) >/dev/null 2>&1

docker-mysql-start: ## Start a MySQL Docker test container.
	@docker run \
	--detach \
	--name $(CONTAINER_TEST_MYSQL_NAME) \
	--publish 3306:3306 \
	--env MYSQL_ALLOW_EMPTY_PASSWORD="yes" \
	--env MYSQL_USER=$(DEFAULT_DATABASE_USER) \
	--env MYSQL_PASSWORD=$(DEFAULT_DATABASE_PASSWORD) \
	--env MYSQL_DATABASE=$(DEFAULT_DATABASE_NAME) \
	--volume $(CONTAINER_TEST_MYSQL_NAME):/var/lib/mysql \
	$(DOCKER_MYSQL_IMAGE_NAME):$(DOCKER_MYSQL_IMAGE_TAG)
	--character-set-server=utf8mb4 \
	--collation-server=utf8mb4_unicode_ci
	@while ! mysql -h 127.0.0.1 --user=$(DEFAULT_DATABASE_USER) --password=$(DEFAULT_DATABASE_PASSWORD) --execute "SHOW TABLES;" $(DEFAULT_DATABASE_NAME) >/dev/null 2>&1; do echo -n .;sleep 2; done

docker-mysql-stop: ## Stop and delete the MySQL container.
	@docker container rm \
	--force $(CONTAINER_TEST_MYSQL_NAME) >/dev/null 2>&1
	@docker volume \
	rm $(CONTAINER_TEST_MYSQL_NAME) >/dev/null 2>&1 || true

docker-mysql-backup:
	@mysqldump --host=127.0.0.1 --no-tablespaces --user=$(DEFAULT_DATABASE_USER) --password=$(DEFAULT_DATABASE_PASSWORD) $(DEFAULT_DATABASE_NAME) > mayan-docker-mysql-backup.sql

docker-mysql-restore:
	@mysql --host=127.0.0.1 --user=$(DEFAULT_DATABASE_USER) --password=$(DEFAULT_DATABASE_PASSWORD) $(DEFAULT_DATABASE_NAME) < mayan-docker-mysql-backup.sql

docker-oracle-start: ## Start an Oracle test container.
docker-oracle-start:
	@docker run \
	--detach \
	--name $(CONTAINER_TEST_ORACLE_NAME) \
	--publish 49160:22 \
	--publish 49161:1521 \
	--env ORACLE_ALLOW_REMOTE=true \
	--volume $(CONTAINER_TEST_ORACLE_NAME):/u01/app/oracle \
	$(DOCKER_ORACLE_IMAGE_VERSION)
	@sleep 10
	@while ! nc -z 127.0.0.1 49161; do echo -n .; sleep 2; done

docker-oracle-stop:
docker-oracle-stop: ## Stop and delete the Oracle test container.
	@docker container \
	rm \
	--force $(CONTAINER_TEST_ORACLE_NAME) >/dev/null 2>&1
	@docker volume \
	rm \
	$(CONTAINER_TEST_ORACLE_NAME) >/dev/null 2>&1 || true

docker-postgresql-start: ## Start a PostgreSQL Docker test container.
	@docker run \
	--detach \
	--name $(CONTAINER_TEST_POSTGRESQL_NAME) \
	--env POSTGRES_HOST_AUTH_METHOD=trust \
	--env POSTGRES_USER=$(DEFAULT_DATABASE_USER) \
	--env POSTGRES_PASSWORD=$(DEFAULT_DATABASE_PASSWORD) \
	--env POSTGRES_DB=$(DEFAULT_DATABASE_NAME) \
	--publish 5432:5432 \
	--volume $(CONTAINER_TEST_POSTGRESQL_NAME):/var/lib/postgresql/data \
	$(DOCKER_POSTGRESQL_IMAGE_NAME):$(DOCKER_POSTGRESQL_IMAGE_TAG)
	@while ! docker exec --interactive --tty $(CONTAINER_TEST_POSTGRESQL_NAME) pg_isready --dbname=$(DEFAULT_DATABASE_NAME) --username=$(DEFAULT_DATABASE_USER) >/dev/null 2>&1; do echo -n .;sleep 1; done

docker-postgresql-stop: ## Stop and delete the PostgreSQL container.
	@docker container \
	rm \
	--force $(CONTAINER_TEST_POSTGRESQL_NAME) >/dev/null 2>&1
	@docker volume \
	rm \
	$(CONTAINER_TEST_POSTGRESQL_NAME) >/dev/null 2>&1 || true

docker-postgresql-backup:
	@PGPASSWORD="$(DEFAULT_DATABASE_PASSWORD)" pg_dump --dbname=$(DEFAULT_DATABASE_NAME) --host=127.0.0.1 --username=$(DEFAULT_DATABASE_USER) > mayan-docker-postgresql-backup.sql

docker-postgresql-restore:
	@cat mayan-docker-postgresql-backup.sql | psql --dbname=$(DEFAULT_DATABASE_NAME) --host=127.0.0.1 --username=$(DEFAULT_DATABASE_USER) > /dev/null

docker-redis-start: ## Start a Redis Docker test container.
docker-redis-start:
	docker run \
	--detach \
	--name $(CONTAINER_TEST_REDIS_NAME) \
	--publish 6379:6379 \
	--volume $(CONTAINER_TEST_REDIS_NAME):/data \
	$(DOCKER_REDIS_IMAGE_NAME):$(DOCKER_REDIS_IMAGE_TAG)
	@while ! docker exec --interactive --tty $(CONTAINER_TEST_REDIS_NAME) redis-cli CONFIG GET databases >/dev/null 2>&1; do echo -n .;sleep 1; done

docker-redis-stop: ## Stop and delete the Redis container.
docker-redis-stop:
	@docker container \
	rm \
	--force \
	$(CONTAINER_TEST_REDIS_NAME) >/dev/null 2>&1
	@docker volume \
	rm \
	$(CONTAINER_TEST_REDIS_NAME) >/dev/null 2>&1 || true

docker-shell: ## Launch a bash instance inside a running container. Pass the container name via DOCKER_CONTAINER.
	docker exec \
	--env TERM=$(TERM) \
	--env "COLUMNS=$(CONSOLE_COLUMNS)" \
	--env "LINES=$(CONSOLE_LINES)" \
	--interactive \
	--tty $(DOCKER_CONTAINER) /bin/bash

docker-runtest-container: ## Run a test container.
docker-runtest-container: docker-test-cleanup
	docker run \
	--detach \
	--name $(CONTAINER_TEST_MAYAN_EDMS_NAME) \
	--publish 80:8000 \
	--volume $(CONTAINER_TEST_MAYAN_EDMS_NAME):/var/lib/mayan \
	$(DOCKER_IMAGE_MAYAN_NAME):$(IMAGE_VERSION)

docker-runtest-cleanup: ## Delete the test container and the test volume.
	@docker container \
	rm \
	--force $(CONTAINER_TEST_MAYAN_EDMS_NAME) || true
	@docker volume rm \
	$(CONTAINER_TEST_MAYAN_EDMS_NAME) || true

docker-runtest-all: ## Executed the test suite in a test container.
	docker run \
	--rm $(DOCKER_IMAGE_MAYAN_NAME):$(IMAGE_VERSION) \
	run_tests
