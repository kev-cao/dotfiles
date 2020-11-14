setxkbmap -option compose:rctrl
[ -f /etc/xprofile ] && . /etc/xprofile
[ -f ~/.xprofile ] && . ~/.xprofile

# xrandr --setprovideroutputsource modesetting NVIDIA-0
# xrandr --auto
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx

~/.scripts/.remap_keys.sh
~/.scripts/.orient_monitors_landscape.sh
/usr/bin/prime-offload
xbindkeys &
fcitx &
exec i3
