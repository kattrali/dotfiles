#!/usr/bin/env fish
# Installs a specified version of a formula by searching the homebrew repository
# git tree, matching on the formula name and exact version number. When multiple
# matches are found, exits immediately to avoid ambiguity.
#
# Example:
#
#     brew-checkout tmux 2.0

function brew-checkout
  if test (count $argv) -eq 2
    set REMOTE_REPO 'https://raw.githubusercontent.com/Homebrew/homebrew'
    set REMOTE_FORMULA_PATH 'Library/Formula'
    set FORMULA (echo $argv[1])
    set VERSION (echo $argv[2])
    set HASH (git -C (brew --prefix) log --all --grep="$FORMULA $VERSION" --pretty="%H")
    if test (count $HASH) -eq 1
      echo Installing $argv[1] $argv[2]
      brew install "$REMOTE_REPO/$HASH/$REMOTE_FORMULA_PATH/$FORMULA.rb"
      brew pin $FORMULA
    else
      echo "No match found for '$FORMULA $VERSION'"
    end
  else
    echo 'Usage: brew-checkout [formula] [version]'
  end
end
