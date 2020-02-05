#!/usr/bin/env fish

alias rm="trash"
alias bk=bookkeeping
alias activate="source ~/.local/venv/bin/activate.fish"
alias v="vim -c Files"

# Navigation
alias wo='cd (ls -d ~/doc/code/bugsnag/{,maintained/}* | fzf --preview "git -C {} status && echo &&  head -n $LINES {}/README.md")'
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."
alias .......="cd ../../../../../.."

# VCS
alias g="git"
alias gx="gitx"
alias gp="git push"
alias gs="git status"

# Haxe
alias flixel="haxelib run flixel-tools"
alias lime="haxelib run lime"
alias ihx="haxelib run ihx"
