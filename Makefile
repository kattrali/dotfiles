BOOTSTRAP_CONFIG=~/Dropbox/Bootstrap
SHELL_CONFIG=~/.config/fish

BOOTSTRAP_TARGET=init
FUNCTION_TARGET=fish/functions

BOOTSTRAP=Makefile Brewfile Pipfile config/weechat.sh
DOTFILES=.tmux.conf .vimrc .muttrc .gitconfig .tigrc
FUNCTIONS=aliases.fish http.fish pw.fish workon.fish checkmail.fish \
	  readmail.fish pass.fish fish_prompt.fish
SHELLRC=$(SHELL_CONFIG)/config.fish

# Synchronize changes for release
all: dotfiles bootstrap-files shell-config defaults

.SECONDARY:

$(BOOTSTRAP_TARGET)/%: $(BOOTSTRAP_CONFIG)/%
	@install -C $(BOOTSTRAP_CONFIG)/$* $(BOOTSTRAP_TARGET)/$*

$(FUNCTION_TARGET)/%: $(SHELL_CONFIG)/functions/%
	@install -C $(SHELL_CONFIG)/functions/$* $(FUNCTION_TARGET)/$*

fish/config.fish: $(SHELLRC)
	@install -C $(SHELLRC) fish/config.fish

.%: $(HOME)/.%
	@install -c $(HOME)/.$* .$*

.PHONY:

function-files: $(addprefix $(FUNCTION_TARGET)/,$(FUNCTIONS))

dotfiles: $(DOTFILES)

bootstrap-files: $(addprefix $(BOOTSTRAP_TARGET)/,$(BOOTSTRAP))

shell-config: fish/config.fish function-files

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
