#!/usr/bin/env fish

function http
  curl -s http://httpcode.info/$argv[1] | less
end
