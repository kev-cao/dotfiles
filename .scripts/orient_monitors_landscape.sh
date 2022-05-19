#!/bin/bash
OPTIMUS_MODE=`optimus-manager --print-mode | grep nvidia`
if [ $? = 0 ]; then
    CONNECTED_MONITORS=`xrandr -q | grep -E "(HDMI-0|DP-0) connected" --count`
    # xrandr -d :0 --output DP-0 --auto
    if [[ CONNECTED_MONITORS -eq 2 ]]; then
        xrandr --output HDMI-0 --auto
        xrandr --output DP-0 --left-of HDMI-0 --primary --auto --panning 1920x1080+0+0
        xrandr --output HDMI-0 --rotate normal
        # Dual monitor setup
        xrandr --output eDP-1-1 --off 

    # Dual monitor + laptop setup
    # xrandr --output eDP-1-1 --auto
    # xrandr --output eDP-1-1 --left-of DP-0
    elif [[ CONNECTED_MONITORS -eq 1 ]]; then
        MONITOR_PORT=`xrandr -q | grep -E "(HDMI-0|DP-0) connected" | grep -E "HDMI-0|DP-0" --only-matching`
        echo $MONITOR_PORT
        xrandr --output $MONITOR_PORT --auto --right-of eDP-1-1 --rotate normal 
        xrandr --output eDP-1-1 --auto --primary
        xrandr --output $MONITOR_PORT --panning 1920x1080+0+0 
    fi
fi
