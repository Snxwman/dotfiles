#!/bin/sh

# System config
/usr/bin/xmodmap ~/.config/.xmodmap  # Cannot be forked or sxhkd will not load the correct binds.

# Audio
/usr/bin/pipewire &  # pipewire.conf loads wireplumber as a module

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
#/sbin/xrandr --output 'HDMI-0' --mode '5120x1440' --primary # Needs to complete before feh.
#/sbin/xrandr --output 'HDMI-1' --mode '1920x1080' --right-of 'HDMI-0'
xrandr \
    --output 'HDMI-1' --mode '5120x1440' --pos 0x1080 --primary \
    --output 'HDMI-0' --mode '1920x1080' --pos 2400x0 --rotate inverted
/sbin/nvidia-settings --load-config-only --config ~/.config/.nvidia-settings-rc
/usr/bin/compfy --daemon &
/usr/bin/feh --no-fehbg --bg-fill '/home/sam/media/photos/wallpaper/32:9/forest.jpg' &

# Theming
/sbin/xrdb << EOF
Xcursor.theme: Simp1e-Mix-Dark
Xcursor.size: 16
EOF  # Imitates ~/.Xresources

/opt/eww daemon &
exec /usr/bin/dbus-run-session /usr/bin/qtile start
