#!/bin/sh

# System config
/usr/bin/xmodmap ~/.config/.xmodmap  # Cannot be forked or sxhkd will not load the correct binds.

# Audio
/usr/bin/pipewire -c ~/.config/pipewire.conf &  # pipewire.conf loads wireplumber as a module

# Backgroud programs
/usr/bin/blueman-applet &
/usr/bin/flameshot &
/usr/bin/sxhkd -c ~/.config/.sxhkdrc &
/usr/bin/syncthing &

# Dont sleep
/sbin/xset s 0 0
/sbin/xset s off
/sbin/xset -dpms

# Graphical environment
#/sbin/xrandr --output 'HDMI-0' --mode '5120x1440'  # Needs to complete before feh.
/sbin/nvidia-settings --load-config-only --config ~/.config/.nvidia-settings-rc
/usr/bin/picom &
/usr/bin/feh --no-fehbg --bg-fill '/home/sam/media/photos/wallpaper/32:9/forest.jpg' &

# Theming
/sbin/xrdb << EOF
Xcursor.theme: Simp1e-Tokyo-Night-Storm
Xcursor.size: 16
EOF  # Imitates ~/.Xresources

exec /usr/bin/dbus-run-session /usr/bin/qtile start
