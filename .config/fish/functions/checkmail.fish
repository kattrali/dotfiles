#!/usr/bin/env fish

function checkmail
  getmail -r getmailrc0 -r getmailrc1 -n -g ~/.config/getmail
  notmuch new
end

