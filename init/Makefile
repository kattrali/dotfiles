PLATFORM=$(shell uname -s)
all:
ifeq ($(PLATFORM),Darwin)
	@echo "Configuring macOS system"
	@$(MAKE) -f macos.mk
else
ifeq ($(PLATFORM),Linux)
	@echo "Configuring Linux system"
	@$(MAKE) -f arch.mk
else
	@echo "No configuration defined"
endif
endif
