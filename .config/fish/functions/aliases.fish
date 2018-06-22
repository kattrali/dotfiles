#!/usr/bin/env fish

alias rm="trash"
alias bk=bookkeeping
alias activate="source ~/.local/venv/bin/activate.fish"
alias v="vim -c Files"

# Navigation
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
# open a command in a new pane
alias tsplit="tmux split-window -h"

# VCS
alias g="git"
alias gx="gitx"
alias gp="git push"
alias gs="git status"

# Haxe
alias flixel="haxelib run flixel-tools"
alias lime="haxelib run lime"
alias ihx="haxelib run ihx"
