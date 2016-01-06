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
    set FORMULA (echo $argv[1])
    set VERSION (echo $argv[2])
    set PREFIX (brew --prefix)
    set HASH (git -C $PREFIX log --all --grep="$FORMULA $VERSION" --pretty="%H")
    set HASH_COUNT (count $HASH)
    if test $HASH_COUNT -eq 1
      echo Installing $argv[1] $argv[2]
      set TMP_FORMULA_PATH (mktemp -dt brew-checkout)/$FORMULA.rb
      git -C $PREFIX show $HASH:Library/Formula/$FORMULA.rb > $TMP_FORMULA_PATH
      brew install $TMP_FORMULA_PATH
      brew pin $FORMULA
      rm -r (dirname $TMP_FORMULA_PATH)
    else if test $HASH_COUNT -eq 0
      echo "No match found for '$FORMULA $VERSION'"
    else
      echo "Too many matches found for '$FORMULA $VERSION'"
    end
  else
    echo 'Usage: brew-checkout [formula] [version]'
  end
end
