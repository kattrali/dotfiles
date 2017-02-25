#!/usr/bin/env fish

function pw
  set STORE ~/.password-store/
  set STOREPAT (echo $STORE | sed 's/\//\\\\\//g')
  set CREDFILE (mktemp)
  ls $STORE/{**,}*.gpg | sed 's/\.gpg//g' | sed "s/$STOREPAT//g" | uniq | fzf > $CREDFILE
  if test $status -eq 0
      set CREDENTIAL (cat $CREDFILE)
      if set -q CREDENTIAL
        pass -c $CREDENTIAL
      end
  end
  /bin/rm -f $CREDFILE
end
