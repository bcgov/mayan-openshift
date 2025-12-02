#!make
include config.env

ifneq ($(wildcard config-local.env),)
        include config-local.env
endif

python-setup-generate: ## Create and update the setup.py file.
python-setup-generate: requirements-generate
	@./contrib/scripts/generate_setup.py
	@echo "Complete."

python-release: ## Package (sdist and wheel) and upload a release.
python-release: clean python-wheel-production
	twine upload dist/* -r pypi

python-sdist-production: ## Build the production source distribution package.
python-sdist-production: clean
	cp MANIFEST-PRODUCTION.in MANIFEST.in
	python setup.py sdist
	ls -l dist

python-sdist-testing: ## Build the testing source distribution package.
python-sdist-testing: clean
	cp MANIFEST-TESTING.in MANIFEST.in
	python setup.py sdist
	ls -l dist

python-wheel-production: ## Build the production wheel distribution package.
python-wheel-production: clean python-sdist-production
	pip wheel --wheel-dir dist dist/*.tar.gz
	ls -l dist

python-wheel-testing: ## Build the testing wheel distribution package.
python-wheel-testing: clean python-sdist-testing
	pip wheel --wheel-dir dist dist/*.tar.gz
	ls -l dist

# Development environment

dev-python-cleanup: ## Clean up all Python libraries.
	@pip freeze > venv-requirements.txt
	@pip uninstall -y -r venv-requirements.txt
	@rm venv-requirements.txt

dev-setup-python: ## Install the Python libraries needed for development.
dev-setup-python: dev-setup-python-base
	pip install --requirement requirements.txt --requirement requirements/development.txt --requirement requirements/testing-base.txt --requirement requirements/documentation.txt
	$(MAKE) dev-setup-python-build

dev-setup-python-base: ## Install base Python packages.
	pip install pip==$(PYTHON_PIP_VERSION)
	pip install setuptools==$(PYTHON_SETUPTOOLS_VERSION)

dev-setup-python-build: ## Install the Python build libraries.
	pip install --requirement requirements/build.txt

dev-setup-python-mysql: ## Install the Python MySQL library.
	@pip install mysqlclient==$(PYTHON_MYSQL_VERSION)

dev-setup-python-oracle: ## Install the Python Oracle library.
	@pip install cx_Oracle==$(PYTHON_ORACLE_VERSION)

dev-setup-python-postgresql: ## Install the Python PostgreSQL library.
	@pip install psycopg==$(PYTHON_PSYCOPG_VERSION)

dev-setup-python-redis:
	@pip install redis==$(PYTHON_REDIS_VERSION)
