PREFIX := /usr/local
BREW_BUNDLE=$(PREFIX)/Library/Taps/homebrew/homebrew-bundle
FONT_DIR=$(HOME)/Library/Fonts
FONTS=$(addprefix $(FONT_DIR),$(shell ls fonts))

.SECONDARY:

all: brew-packages python-packages app-config $(FONTS) cache-fonts
	dropboxd
	@echo "Synchronization started. Remember to run 'mackup restore'"

/usr/bin/clang:
	xcode-select --install

$(PREFIX)/bin/brew:
	@echo Installing Homebrew
	@ruby -e "`curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install`"
	@brew doctor

$(BREW_BUNDLE): $(PREFIX)/bin/brew
	brew tap Homebrew/bundle

$(FONT_DIR)/%:
	@install -C fonts/$* $(FONT_DIR)/$*

.PHONY:

brew-packages: /usr/bin/clang $(BREW_BUNDLE)
	brew bundle Brewfile

python-packages:
	@pip install --upgrade pip
	@pip install -r Pipfile

app-config: weechat

vim:
	@install -d $(HOME)/.vim/autoload
	curl -fLo $(HOME)/.vim/autoload/plug.vim  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

weechat:
	@./config/weechat.sh

cache-fonts:
	fc-cache
