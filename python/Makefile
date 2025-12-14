#!make
include config.env

ifneq ($(wildcard config-local.env),)
        include config-local.env
endif


python-test-release: ## Package (sdist and wheel) and upload to the PyPI test server.
python-test-release: clean wheel
	twine upload dist/* -r testpypi
	@echo "Test with: pip install --index-url https://testpypi.python.org/pypi mayan-edms"

python-release: ## Package (sdist and wheel) and upload a release.
python-release: clean python-wheel
	twine upload dist/* -r pypi

python-sdist: ## Build the source distribution package.
python-sdist: clean
	python setup.py sdist
	ls -l dist

python-wheel: ## Build the wheel distribution package.
python-wheel: clean python-sdist
	pip wheel --no-index --no-deps --wheel-dir dist dist/*.tar.gz
	ls -l dist

python-sdist-test-suit: ## Run the test suit from a built sdist package
python-sdist-test-suit: python-sdist
	rm --force --recursive _virtualenv
	virtualenv _virtualenv
	sh -c '\
	. _virtualenv/bin/activate; \
	pip install `ls dist/*.gz`; \
	_virtualenv/bin/mayan-edms.py common_initial_setup; \
	pip install --requirement requirements/testing.txt; \
	_virtualenv/bin/mayan-edms.py test --mayan-apps \
	'

python-wheel-test-suit: ## Run the test suit from a built wheel package
python-wheel-test-suit: wheel
	rm --force --recursive _virtualenv
	virtualenv _virtualenv
	sh -c '\
	. _virtualenv/bin/activate; \
	pip install `ls dist/*.whl`; \
	_virtualenv/bin/mayan-edms.py common_initial_setup; \
	pip install mock==2.0.0; \
	_virtualenv/bin/mayan-edms.py test --mayan-apps \
	'

generate-setup: ## Create and update the setup.py file.
generate-setup: generate-requirements
	@./contrib/scripts/generate_setup.py
	@echo "Complete."

setup-dev-python-libraries: ## Install the Python libraries needed for development.
	pip install --requirement requirements.txt --requirement requirements/development.txt --requirement requirements/testing-base.txt --requirement requirements/documentation.txt --requirement requirements/build.txt

setup-python-mysql:
	@pip install mysqlclient==$(PYTHON_MYSQL_VERSION)

setup-python-oracle:
	@pip install cx_Oracle==$(PYTHON_ORACLE_VERSION)

setup-python-postgresql:
	@pip install psycopg==$(PYTHON_PSYCOPG_VERSION)

setup-python-redis:
	@pip install redis==$(PYTHON_REDIS_VERSION)
