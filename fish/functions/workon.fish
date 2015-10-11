#!/usr/bin/env fish

# Search through my code directories and quickly open project folder
# wo = workon
function workon
  set -l code_dir ~/Code
  if count $argv >/dev/null
    cd (find $code_dir -type d -maxdepth 3 | grep -i $argv | grep -Ev Pods --max-count=1)
  else
    cd (ls -d $code_dir/*/* | fzf)
  end
end
