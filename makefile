.PHONY: format
format:
	ruff format .

.PHONY: lint
lint:
	ruff check .

.PHONY: format_check
format_check:
	ruff format --check .

.PHONY: lint_check
lint_check:
	ruff check --no-fix .

.PHONY: type_check
type_check:
	mypy .

.PHONY: test
test:
	pytest .

.PHONY: check
check: format lint type_check test
