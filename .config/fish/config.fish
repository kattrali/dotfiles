#!/usr/bin/env fish

set fish_greeting
set -x GOPATH $HOME/tmp/go
set -x MAILDIR $HOME/mail/INBOX
set -x EDITOR vim
set -x MANPAGER vimpager
set -x HAXELIB_PATH /usr/local/lib/haxelib
set -x HAXE_STD_PATH /usr/local/lib/haxe/std
set -x COCOAPODS_DISABLE_STATS 1
set -x PIP_REQUIRE_VIRTUALENV 1
set -x HOMEBREW_NO_AUTO_UPDATE 1
set -x HOMEBREW_NO_ANALYTICS 1
set -x HOMEBREW_NO_INSTALL_CLEANUP 1
set -x HOMEBREW_CASK_OPTS "--appdir=~/bin/apps"
set -x PKG_CONFIG_PATH /usr/local/lib/pkgconfig /usr/local/lib
set -x PATH $HOME/bin /usr/local/bin /usr/local/sbin \
            /bin /usr/bin /usr/sbin /sbin $GOPATH/bin

source $HOME/.config/fish/functions/aliases.fish
eval (gpg-agent --daemon | sed -e "s/\(.*\)=\(.*\); export/set -x \1 \2/")
status --is-interactive; and . (swiftenv init -|psub)
status --is-interactive; and . (pyenv init -|psub)
status --is-interactive; and . (rbenv init -|psub)
