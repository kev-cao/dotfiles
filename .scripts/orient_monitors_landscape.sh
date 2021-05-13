#!/bin/bash
OPTIMUS_MODE=`optimus-manager --print-mode | grep nvidia`

if [ $? = 0 ]; then
  CONNECTED_MONITORS=`xrandr -q | grep -E "(HDMI-0|DP-0) connected" --count`
  if [[ CONNECTED_MONITORS -eq 2 ]]; then
    xrandr --output DP-0 --auto
    xrandr --output HDMI-0 --auto
    xrandr --output DP-0 --left-of HDMI-0 --primary
    xrandr --output HDMI-0 --rotate normal
    # Dual monitor setup
    # xrandr --output eDP-1-1 --off 

    # Dual monitor + laptop setup
    xrandr --output eDP-1-1 --auto
    xrandr --output eDP-1-1 --left-of DP-0
  elif [[ CONNECTED_MONITORS -eq 1 ]]; then
    MONITOR_PORT=`xrandr -q | grep -E "(HDMI-0|DP-0) connected" | grep -E "HDMI-0|DP-0" --only-matching`
    xrandr --output eDP-1-1 --auto --primary
    xrandr --output $MONITOR_PORT --auto
    xrandr --output $MONITOR_PORT --right-of eDP-1-1
    xrandr --output $MONITOR_PORT --rotate normal
  fi
fi
