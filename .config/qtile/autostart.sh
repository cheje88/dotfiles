#! /bin/bash
# sleep 3s && ~/.screenlayout/3mon.sh &
sleep 6s && ~/.screenlayout/3mon.sh &
sleep 7s && picom &
# nitrogen --random --set-scaled &
sleep 8s && feh --bg-fill --randomize ~/Dropbox/Fotos/Fondos/* &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
sxhkd &
flameshot &
xscreensaver -no-splash &
blueman-applet &
numlockx on &
xfce4-power-manager &
# xfce4-notifyd &
nm-applet &
clipit &
dunst &
udiskie -t &
xclip &
sleep 30s && xset r rate 300 60 &
xinput set-prop 12 371 1 &
xinput set-prop "ELAN0710:01 04F3:30ED Touchpad" "libinput Tapping Enabled" 1 &
sleep 15s && xinput map-to-output "Wacom Intuos S Pen stylus" HDMI-1-0 &
sleep 15s && dropbox &
xiccd &
