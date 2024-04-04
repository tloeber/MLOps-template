SHELL := /bin/bash
# Set major and minor version of python
PYTHON := python3.11
PROJECT_NAME := MLOps_template
VENV_LOCATION := ~/.virtual_environments/${PROJECT_NAME}

env:
	# (Re-)create directory for virtual environments
	rm -rf ${VENV_LOCATION}
	mkdir -p ${VENV_LOCATION}
	# Create virtual environment manually, so we control name. Then use poetry from *within* the virtual env.
	# Just in case, deactivate any activate environment first
	( deactivate || echo "no virtual env active" ) && \
		${PYTHON} -m venv ${VENV_LOCATION} && \
		source ${VENV_LOCATION}/bin/activate && \
		echo "Python version used: $(which python)" && \
		${PYTHON} -m pip install poetry && \
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
