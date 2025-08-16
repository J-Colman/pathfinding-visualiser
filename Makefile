PYTHON = python3.13

.PHONY: setup check-readme

setup:
	@if [ ! -d "venv" ]; then \
		echo "Creating virtual environment..."; \
		$(PYTHON) -m venv venv; \
	fi

	@./venv/bin/pip install --upgrade pip > /dev/null

	@echo "Installing dependencies from requirements.txt..."
	@./venv/bin/pip install -r requirements.txt > /dev/null
	@./venv/bin/python --version | grep "Python 3.13.3" >/dev/null

	@echo "OK: environment ready ($$(./venv/bin/python --version))"

check-readme:
	@echo "Running README scope check..."

	@grep -q "## Project Scope" README.md
	@grep -q "4-connected grid graph" README.md
	@echo "...Project Scope section found."

	@grep -q "### Coordinates & Movement" README.md
	@grep -q "50×50 grid" README.md
	@echo "...Coordinates & Movement section found."

	@grep -q "### I/O Schema" README.md
	@grep -q "cost\` == \`len(path) - 1" README.md
	@grep -q "path\` == \`null" README.md
	@echo "...I/O Schema section found."

	@grep -q "h(u) ≤ 1 + h(v)" README.md
	@grep -q "|h(u) − h(v)| ≤ 1" README.md
	@echo "...Heuristic inequalities found."

	@grep -q "### Graph Interface" README.md
	
	@grep -q "neighbors(node)" README.md
	@echo "...Graph Interface section found."

	@echo "OK: README scope complete"