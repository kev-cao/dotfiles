#!/bin/bash
# Set left handed mode.
xsetwacom set "HID 256c:006e Pen stylus" rotate half

# Set monitor bounds
XOFFSET=0
xsetwacom set "HID 256c:006e Pen stylus" MapToOutput 1920x1080+${XOFFSET}+0

# Set button keybindings
# Lowest button is button 2, above that is button 3.
# xsetwacom set "HID 256c:006e pad" Button 1 "key ctrl z"
# xsetwacom set "HID 256c:006e pad" Button 2 "key ctrl shift z"
