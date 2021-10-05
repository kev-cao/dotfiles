#!/bin/bash

sudo bash -c '> /etc/X11/xorg.conf'
sudo bash -c 'sed -i "s/startup_mode=\w\+/startup_mode=integrated/" /etc/optimus-manager/optimus-manager.conf'
