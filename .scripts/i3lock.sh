#!/bin/sh

darkgrey="#C0BFC033"
lightgrey="#E1DFE155"
green="#00CA4E99"
red="#FF605C99"
orange="#FFBD4499"
white="#F5F5F555"
blue="#54ACE399"


i3lock --blur=.1 --keyhlcolor=$green --bshlcolor=$orange \
  --ringcolor=$lightgrey --insidecolor=$darkgrey \
  --ringwrongcolor=$red --insidewrongcolor=$darkgrey \
  --ringvercolor=$blue --insidevercolor=$darkgrey \
  --separatorcolor=$lightgrey \
  --greetertext="Enter the Password" --greetercolor=#FFFFFFAA \
  --greeterpos="x+w/2:y+h/2+r*1.5" --greetersize=24 \
  --veriftext="" --wrongtext="" --noinputtext="" \
  --image="/home/kevin/Pictures/rice/lock.png" --centered \
  --radius=85 --line-uses-inside --indicator --ignore-empty-password
