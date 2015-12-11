#!/usr/bin/env fish

alias rm="trash"
alias t="todo.sh -d ~/Dropbox/todo/config"

# Navigation
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias wo=workon

# VCS
alias g="git"
alias gx="gitx"
alias gp="git push"
alias gs="git status"

# Search
function web
  open "https://duckduckgo.com?q=$argv"
end

function gh
  open "https://github.com/search/?q=$argv"
end
