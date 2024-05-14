SHELL := /bin/bash
include terraform/.env

# Set major and minor version of python
PYTHON := python3.11
PROJECT_NAME := MLOps_template
VENV_LOCATION := ~/.virtual_environments/${PROJECT_NAME}

env:
	# Remove exiting virtual environments, if found
	( rm -rf .venv && echo "Removing existing venv" ) || \
		echo "No existing virtual environment found."

	# Set poetry to install virtual environment into *project* folder, because otherwise venv name
	# is not deterministic. See https://github.com/python-poetry/poetry/issues/263
	# Just in case, deactivate any activate environment first
	( deactivate &> /dev/null || echo "No virtual env active" ) && \
		${PYTHON} -m pip install poetry && \
		${PYTHON} -m poetry config virtualenvs.in-project true && \
		${PYTHON} -m poetry lock && \
		${PYTHON} -m poetry install --all-extras

env-update:
	${PYTHON} -m poetry update

type-check:
	mypy src/my_project --exclude '_tmp/' --exclude '_old/'

find-missing-typestubs:
	@# First *run* type check to refresh mypy cache, but ignore any errors for now.
	@mypy src/my_project --exclude '_tmp/' &> /dev/null || echo ""
	@echo "Looking for missing type stubs. If any, abort install using 'N' and install directly "
	@echo "using 'poetry add --group dev <packages>'"
	@mypy --install-types

find-untyped-imports:
	@echo "Untyped imports ignored:"
	@# Note: -F is for fixed strings, so it's not interpreted as a regex
	@cat $$(find src/my_project -type f -name '*.py') | grep -F 'type: ignore[import-untyped]' || echo "None found"
	@echo ""
	@echo "Untyped imports found:"
	@mypy src/my_project --exclude '_tmp/' --exclude '_old/' |  grep -F 'import-untyped' || echo "None found"

test:
	poetry run pytest

build:
	poetry build

publish:
	poetry publish

authenticate-databricks:
	databricks auth login --host ${DATABRICKS_WORKSPACE_URL}
