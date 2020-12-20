#!/bin/bash
sudo bash -c 'cat /etc/X11/xorg > /etc/X11/xorg.conf'
#xrandr --setprovideroutputsource modesetting NVIDIA-0
#xrandr --auto
#startx
sudo bash -c 'sed -i "s/startup_mode=\w\+/startup_mode=nvidia/" /etc/optimus-manager/optimus-manager.conf'
