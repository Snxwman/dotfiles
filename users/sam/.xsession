#!/bin/sh

# System config
/usr/bin/xmodmap ~/.config/.xmodmap

# Audio
/usr/bin/pipewire &

# Backgroud programs
/usr/bin/sxhkd -c ~/.config/.sxhkdrc &
/usr/bin/flameshot &

# Graphical environment
/usr/bin/picom &
exec /usr/bin/dbus-run-session /usr/bin/qtile start
