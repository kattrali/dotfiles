PREFIX := /usr/local
BREW_BUNDLE=$(PREFIX)/Library/Taps/homebrew/homebrew-bundle
FONT_DIR=$(HOME)/Library/Fonts
FONTS=$(addprefix $(FONT_DIR),$(shell ls fonts))

.SECONDARY:

all: defaults brew-packages python-packages app-config $(FONTS) cache-fonts
	dropboxd
	@echo "Synchronization started. Remember to run 'mackup restore'"

/usr/bin/clang:
	@xcode-select --install

$(PREFIX)/bin/brew:
	@echo Installing Homebrew
	@ruby -e "`curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install`"
	@brew doctor

$(BREW_BUNDLE): $(PREFIX)/bin/brew
	@brew tap Homebrew/bundle

$(FONT_DIR)/%:
	@install -C fonts/$* $(FONT_DIR)/$*

.PHONY:

brew-packages: /usr/bin/clang $(BREW_BUNDLE)
	@brew bundle Brewfile
	@brew pin tmux

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

defaults:
	@defaults write com.apple.finder QuitMenuItem -bool true
	@defaults write com.apple.universalaccess reduceTransparency -bool true
	@defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
	@defaults write com.apple.Safari IncludeDevelopMenu -bool true
	@defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
	@defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true
	@defaults write NSGlobalDomain WebKitDeveloperExtras -bool true
	@defaults write com.apple.TextEdit RichText -int 0
	@defaults write NSGlobalDomain AppleShowAllExtensions -bool true
	@defaults write com.apple.finder AppleShowAllFiles true
	@defaults write NSGlobalDomain NSScrollAnimationEnabled -bool false
	@defaults write com.apple.finder CreateDesktop -bool false
	@defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false
	@defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
	@defaults write com.apple.finder NewWindowTarget -string "PfLo"
	@defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/Code"
	@defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
	@defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true
	@defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false
	@defaults write com.apple.screencapture type -string "png"
	@defaults write com.apple.screencapture disable-shadow -bool true
	@chflags nohidden ~/Library
	@killall Finder
	@killall SystemUIServer
