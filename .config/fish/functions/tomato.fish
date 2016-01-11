#!/usr/bin/env fish
# A timer for pomodoro-alike working schedules
# Usage:
#
#   tomato [task] # Starts a timer for $TOMATO_WORK_LEN
#   tomato break  # Starts a time for $TOMATO_BREAK_LEN

function tomato
  set TOMATO_BREAK_LEN 5m
  if test (count $argv) -eq 0
    _tomato_work
  else if test (echo $argv[1]) = 'break'
    echo "Take a break :)"
    utimer -t $TOMATO_BREAK_LEN; and say 'back to work!'
  else
    echo "Next task: $argv[1..-1]"
    _tomato_work
  end
end

function _tomato_work
  set TOMATO_WORK_LEN 20m
  echo "Time for work!"
  utimer -t $TOMATO_WORK_LEN; and say 'done'
end

