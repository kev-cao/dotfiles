#!/bin/bash
CHECK_MONITORS=`xrandr -q | grep -E "HDMI-0|DP-0" | grep disconnected`

HAS_DUAL_MONITORS=$?

if [ $HAS_DUAL_MONITORS -ne 0 ]; then
  xrandr --output DP-0 --auto --primary
  xrandr --output HDMI-0 --auto
  xrandr --output DP-0 --primary --left-of HDMI-0 -- pos 0x798
  xrandr --output HDMI-0 --rotate right --pos 1920x0
  xrandr --output eDP-1-1 --off
fi
