#!/bin/sh

# Audio
/usr/bin/pipewire &

# Backgroud programs
/usr/bin/sxhkd &
/usr/bin/flameshot &

# Graphical environment
/usr/bin/picom &
exec /usr/bin/dbus-run-session /usr/bin/qtile start
