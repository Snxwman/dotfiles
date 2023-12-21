#!/bin/sh

# System config
/usr/bin/xmodmap ~/.config/.xmodmap  # Cannot be forked or sxhkd will not load the correct binds.

# Audio
/usr/bin/pipewire -c ~/.config/pipewire.conf &

# Backgroud programs
/usr/bin/syncthing &
/usr/bin/sxhkd -c ~/.config/.sxhkdrc &
/usr/bin/flameshot &

# Graphical environment
/sbin/xrandr --output 'HDMI-0' --mode '5120x1440'  # Needs to complete before feh.
/usr/bin/picom &
/usr/bin/feh --no-fehbg --bg-fill '/home/sam/media/photos/wallpaper/32:9/forest.jpg' &
exec /usr/bin/dbus-run-session /usr/bin/qtile start
