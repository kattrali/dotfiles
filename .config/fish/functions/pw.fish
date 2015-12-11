#!/usr/bin/env fish

function pw
  set CREDFILE (echo "/tmp/pw"(random)".txt")
  pass | fzf | sed 's/\.gpg//g' | awk '{ print $NF }' 2>/dev/null > $CREDFILE
  set CREDENTIAL (cat $CREDFILE)
  if set -q CREDENTIAL
    pass -c $CREDENTIAL
  end
  /bin/rm -f $CREDFILE
end
