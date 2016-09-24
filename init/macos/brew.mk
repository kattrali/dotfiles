PREFIX := /usr/local
HOMEBREW_INSTALLER=https://raw.githubusercontent.com/Homebrew/install/master/install
BREW_BUNDLE=$(PREFIX)/Homebrew/Library/Taps/homebrew/homebrew-bundle
BREW=$(PREFIX)/bin/brew
XCODE=/Applications/Xcode.app

all: packages

$(XCODE):
	@xcode-select --install

$(BREW): $(XCODE)
	@echo Installing Homebrew
	@ruby -e "`curl -fsSL $(HOMEBREW_INSTALLER)`"
	@brew doctor

$(BREW_BUNDLE): $(BREW)
	@brew tap Homebrew/bundle

packages: $(BREW_BUNDLE)
	@brew bundle Brewfile
