#!/usr/bin/env fish

set fish_greeting
set -x GOPATH $HOME/Code/gopkg
set -x MAILDIR $HOME/mail
set -x EDITOR vim
set -x GEM_HOME $HOME/.local/gems/(ruby -v | awk '{print $2}')
set -x GEM_PATH $GEM_HOME
set -x COCOAPODS_DISABLE_STATS 1
set -x PATH /usr/bin $GEM_HOME/bin $HOME/bin \
            /usr/local/bin /usr/local/sbin $GOPATH/bin \
            /bin /usr/sbin /sbin /usr/local/go/bin

source /usr/local/share/chruby/chruby.fish
source $HOME/.config/fish/functions/aliases.fish
