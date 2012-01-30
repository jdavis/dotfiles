#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

###
#
# Before my Gnome days... Sigh, such nostalgia.
#
###
# Set my Wallpaper
#feh --bg-scale ~/Pictures/Wallpapers/Snow.jpg &

# Make the cursor pretty
xsetroot -cursor_name left_ptr &

# Turn off the obnoxious bell.
xset b off

# Wireless is nice.
# wicd-client &

# Start Dropbox
dropboxd &

# Start up the Screensaver
#xscreensaver -no-splash &

# Disable the trackpad when my clumsy hands are typing
#syndaemon -K -i 1 -d

# Get me keys right
#setxkbmap -option terminate:ctrl_alt_bksp
#(sleep 1; xmodmap ~/.Xmodmap) &

# Go go gadget, XMonad!
#exec urxvt
#exec ck-launch-session xmonad
exec ck-launch-session awesome

# I CHOOSE YOU XFCE!!
#exec ck-launch-session startxfce4
