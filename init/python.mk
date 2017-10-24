VENV=~/.local/venv

all:
	@python3 -m venv $(VENV)
	@source $(VENV)/bin/activate.fish
	@pip install --upgrade pip
	@pip install -r Pipfile
