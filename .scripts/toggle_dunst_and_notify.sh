#!/bin/bash
if (dunstctl is-paused | grep -q 'false');
then
  notify-send "Muting notifications."
  sleep 1 
  dunstctl set-paused true
else
  dunstctl close-all
  dunstctl set-paused false
  notify-send "Unmuting notifications."
  sleep 1
  dunstctl close
fi
