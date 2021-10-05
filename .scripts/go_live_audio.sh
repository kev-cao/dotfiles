#!/bin/bash
pactl load-module module-null-sink sink_name=Virtual1
pactl load-module module-loopback source=alsa_input.usb-Logitech_G432_Gaming_Headset_000000000000-00.mono-fallback sink=Virtual1
pactl load-module module-loopback source=Virtual1.monitor sink=alsa_output.usb-Logitech_G432_Gaming_Headset_000000000000-00.analog-stereo
