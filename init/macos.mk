.SECONDARY:

all: home-layout defaults brew-packages python-packages app-config services
	@echo "Next steps: "
	@echo "* Run 'make allow-ax' to set accessibility permissions"
	@echo "* Start sync and run 'mackup restore'"

.PHONY:

brew-packages:
	@$(MAKE) -f macos/brew.mk

app-config: weechat vim

vim:
	@$(MAKE) -f vim.mk

weechat:
	@$(MAKE) -f weechat.mk

python-packages:
	@$(MAKE) -f python.mk

home-layout:
	@mkdir -p ~/tmp/{code,downloads,go,screenshots}
	@mkdir -p ~/mail/{cur,new,tmp}
	@mkdir -p ~/bin/{apps,games}
	@mkdir -p ~/doc/{appdata,code,financials}
	@mkdir -p ~/.vim/{bundle,autoload,tmp}
	@chflags -h hidden ~/Desktop
	@ln -sf /Users/delisa/tmp/downloads /Users/delisa/Downloads
	@chflags -h hidden ~/Downloads
	@ln -sf /Users/delisa/doc/appdata /Users/delisa/Documents
	@chflags -h hidden ~/Documents
	@ln -sf /Users/delisa/media/video /Users/delisa/Movies
	@chflags -h hidden ~/Movies
	@ln -sf /Users/delisa/media/img /Users/delisa/Pictures
	@chflags -h hidden ~/Pictures
	@ln -sf /Users/delisa/media/music /Users/delisa/Music
	@chflags -h hidden ~/Music

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

services:
	launchctl load init/macos/services/me.delisa.offlineimap.plist
