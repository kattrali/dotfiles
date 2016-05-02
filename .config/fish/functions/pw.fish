#!/usr/bin/env fish

function pw
  set CREDFILE (mktemp)
  fish -c 'pass | awk \'{ print $NF}\' | sed \'s/\.gpg$//g\' | fzf' > $CREDFILE
  set CREDENTIAL (cat $CREDFILE)
  if set -q CREDENTIAL
    pass -c $CREDENTIAL
  end
  /bin/rm -f $CREDFILE
end
