all:
ifeq ($(shell uname),Darwin)
	@echo "Configuring macOS system"
	@$(MAKE) -f macos.mk
else
	@echo "No configuration defined"
endif
