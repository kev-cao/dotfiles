#!/bin/bash

device="ETPS/2 Elantech Touchpad"
state=$(xinput list-props "$device" | grep "Device Enabled" | grep -o "[01]$")

if [ $state == '1' ];then
  xinput --disable "$device"
else
  xinput --enable "$device"
fi
