#!/usr/bin/env fish

function readmail
  mutt -f $MAILDIR
end

