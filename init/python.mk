PIP=PIP_REQUIRE_VIRTUALENV=false pip

all:
	@$(PIP) install --upgrade pip
	@$(PIP) install -r Pipfile
