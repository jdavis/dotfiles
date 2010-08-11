#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

# exec gnome-session
# exec startkde
# exec startxfce4
# ...or the Window Manager of your choice

# Set my Wallpaper
feh --bg-scale ~/Pictures/Wallpapers/Snow.jpg &

# Make the cursor pretty
xsetroot -cursor_name left_ptr &

# Start up the Screensaver
xscreensaver -no-splash &

# Disable the trackpad when my clumsy hands are typing
syndaemon -K -i 1 -d

# Get me keys right
#setxkbmap -option terminate:ctrl_alt_bksp
#(sleep 1; xmodmap ~/.Xmodmap) &

# Go go gadget, XMonad!
#exec xmonad

# I CHOOSE YOU XFCE!!
exec ck-launch-session startxfce4

# Testing purposes
#exec urxvt
#exec xterm
