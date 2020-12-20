#!/bin/bash
OPTIMUS_MODE=`optimus-manager --print-mode | grep nvidia`

if [ $? = 0 ]; then
  DISCONNECTED_MONITORS=`xrandr -q | grep -E "HDMI-0|DP-0" | grep disconnected`
  if [ $? -ne 0 ]; then
    xrandr --output DP-0 --auto
    xrandr --output HDMI-0 --auto
    xrandr --output DP-0 --left-of HDMI-0 --primary
    xrandr --output HDMI-0 --rotate normal
    xrandr --output eDP-1-1 --off
  fi
fi
