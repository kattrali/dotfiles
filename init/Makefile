PREFIX := /usr/local
BREW_BUNDLE=$(PREFIX)/Library/Taps/homebrew/homebrew-bundle
WEECHAT_CFG=$(HOME)/.weechat
WEECHAT_PYCFG=$(WEECHAT_CFG)/python/autoload
WEECHAT_PERLCFG=$(WEECHAT_CFG)/perl/autoload

.SECONDARY:

all: defaults brew-packages python-packages app-config
	@echo "Next steps: Start sync and run 'mackup restore'"
	@echo "Run 'make allow-ax' to set accessibility permissions"

/usr/bin/clang:
	@xcode-select --install

$(PREFIX)/bin/brew:
	@echo Installing Homebrew
	@ruby -e "`curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install`"
	@brew doctor

$(BREW_BUNDLE): $(PREFIX)/bin/brew
	@brew tap Homebrew/bundle

$(HOME)/.vim/autoload/plug.vim:
	@install -d $(HOME)/.vim/autoload
	curl -fLo $(HOME)/.vim/autoload/plug.vim  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

$(WEECHAT_PYCFG)/wee_slack.py:
	@install -d $(WEECHAT_PYCFG)
	@cd $(WEECHAT_PYCFG); \
		wget https://raw.githubusercontent.com/rawdigits/wee-slack/master/wee_slack.py

$(WEECHAT_PYCFG)/weemoji.py:
	@install -d $(WEECHAT_PYCFG)
	@cd $(WEECHAT_PYCFG); \
		wget https://raw.githubusercontent.com/kattrali/weemoji/master/wee_slack.py

$(WEECHAT_PERLCFG)/buffers.pl:
	@install -d $(WEECHAT_PERLCFG)
	@cd $(WEECHAT_PERLCFG); \
		wget https://weechat.org/files/scripts/buffers.pl

.PHONY:

brew-packages: /usr/bin/clang $(BREW_BUNDLE)
	@brew bundle Brewfile
	@brew pin tmux

python-packages:
	@pip install --upgrade pip
	@pip install -r Pipfile

app-config: weechat vim swiftenv

vim: $(HOME)/.vim/autoload/plug.vim

weechat: $(WEECHAT_PYCFG)/wee_slack.py $(WEECHAT_PYCFG)/weemoji.py $(WEECHAT_PERLCFG)/buffers.pl

cache-fonts:
	fc-cache

home-layout:
	@mkdir -p ~/tmp/{code,downloads,go,screenshots}
	@mkdir -p ~/mail/{cur,new,tmp}
	@mkdir -p ~/bin/{apps/games}
	@mkdir -p ~/doc/{appdata,code,financials}
	@chflags -h hidden ~/Desktop
	@ln -s /Users/delisa/tmp/downloads/ /Users/delisa/Downloads
	@chflags -h hidden ~/Downloads
	@ln -s /Users/delisa/doc/appdata /Users/delisa/Documents
	@chflags -h hidden ~/Documents
	@ln -s /Users/delisa/media/video /Users/delisa/Movies
	@chflags -h hidden ~/Movies
	@ln -s /Users/delisa/media/music /Users/delisa/Pictures
	@chflags -h hidden ~/Music
	@ln -s /Users/delisa/media/img /Users/delisa/Pictures
	@chflags -h hidden ~/Pictures

defaults:
	@defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false
	@defaults write NSGlobalDomain AppleShowAllExtensions -bool true
	@defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false
	@defaults write NSGlobalDomain NSScrollAnimationEnabled -bool false
	@defaults write NSGlobalDomain WebKitDeveloperExtras -bool true
	@defaults write com.apple.Safari DownloadsPath -string "~/tmp/downloads"
	@defaults write com.apple.Safari IncludeDevelopMenu -bool true
	@defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
	@defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true
	@defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
	@defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true
	@defaults write com.apple.TextEdit RichText -int 0
	@defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
	@defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true
	@defaults write com.apple.finder AppleShowAllFiles true
	@defaults write com.apple.finder CreateDesktop -bool false
	@defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
	@defaults write com.apple.finder NewWindowTarget -string "PfLo"
	@defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/projects"
	@defaults write com.apple.finder QuitMenuItem -bool true
	@defaults write com.apple.screencapture disable-shadow -bool true
	@defaults write com.apple.screencapture type -string "png"
	@defaults write com.apple.screencapture location ${HOME}/tmp/screenshots
	@defaults write com.apple.universalaccess reduceTransparency -bool true
	@killall Finder
	@killall SystemUIServer

allow-ax:
	sudo sqlite3 /Library/Application\ Support/com.apple.TCC/TCC.db "INSERT INTO access VALUES('kTCCServiceAccessibility','com.amethyst.Amethyst',0,1,1,NULL);"
	sudo sqlite3 /Library/Application\ Support/com.apple.TCC/TCC.db "INSERT INTO access VALUES('kTCCServiceAccessibility','com.runningwithcrayons.Alfred-2',0,1,1,NULL);"
	sudo sqlite3 /Library/Application\ Support/com.apple.TCC/TCC.db "INSERT INTO access VALUES('kTCCServiceAccessibility','org.pqrs.Karabiner',0,1,1,NULL);"
