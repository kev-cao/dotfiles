#!/bin/sh

darkgrey="#C0BFC033"
lightgrey="#E1DFE155"
green="#00CA4E99"
red="#FF605C99"
orange="#FFBD4499"
white="#F5F5F555"
blue="#54ACE399"


i3lock --blur=.1 --keyhl-color=$green --bshl-color=$orange \
  --ring-color=$lightgrey --inside-color=$darkgrey \
  --ringwrong-color=$red --insidewrong-color=$darkgrey \
  --ringver-color=$blue --insidever-color=$darkgrey \
  --separator-color=$lightgrey \
  --greeter-text="Enter the Password" --greeter-color=#FFFFFFAA \
  --greeter-pos="x+w/2:y+h/2+r*1.5" --greeter-size=24 \
  --verif-text="" --wrong-text="" --noinput-text="" \
  --radius=85 --line-uses-inside --indicator --ignore-empty-password \
  --image="/home/kevin/Pictures/rice/lock.png" --centered \
  -c 00000000
