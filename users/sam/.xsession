#!/bin/sh

# System config
/usr/bin/xmodmap ~/.config/.xmodmap &

# Audio
/usr/bin/pipewire &

# Backgroud programs
/usr/bin/syncthing &
/usr/bin/sxhkd -c ~/.config/.sxhkdrc &
/usr/bin/flameshot &

# Graphical environment
/usr/bin/picom &
/usr/bin/feh --no-fehbg --bg-fill '/home/sam/media/photos/wallpaper/32:9/forest.jpg' &
exec /usr/bin/dbus-run-session /usr/bin/qtile start
