#!/usr/bin/env fish

function tomato
   if echo $argv | grep 'break' 1>/dev/null
     utimer -t 5m; and say 'back to work!'
   else
     utimer -t 20m; and say 'done'
   end
end
