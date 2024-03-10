SHELL := /bin/bash

env:
	(python3 -m poetry --version > /dev/null) || pip3 install poetry
	python3 -m poetry lock
	python3 -m poetry install --all-extras
	python3 -m poetry shell

env-update:
	python3 -m poetry update

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
