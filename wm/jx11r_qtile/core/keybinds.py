from libqtile.config import Key
from libqtile.lazy import lazy

# Remap 'mod' keys to nice names
alt = 'mod1'
numlock = 'mod2'
super = 'mod4'
altgr = 'mod5'

# Key aliases
ctrl = 'control'
shift = 'shift'
tab = 'Tab'
enter = 'return'
space = 'space'
left = 'Left'
down = 'Down'
up = 'Up'
right = 'Right'
backspace = 'BackSpace'

# Special key combo names
meh = [ctrl, alt, shift]
hyper = [ctrl, alt, shift, super]

# Applications
terminal = 'ghostty'
launcher = '.config/rofi/scripts/launcher_t1'
browser = 'brave'
file_manager = 'nautilus'
logout = ''

keys = [
    # System control
    Key([super, alt], 'w', lazy.window.kill()),
    Key([super, ctrl], 'r', lazy.restart()),
    Key([super], space, lazy.spawn(launcher)),

    # Application shortcuts
    Key([super], enter, lazy.spawn(terminal)),
    Key([super], 'd', lazy.spawn(browser)),
    Key([super], 's', lazy.spawn(file_manager)),

    # Screen navigation
    Key([super], 'n', lazy.next_screen()),
    Key([super, shift], '1', lazy.group['Dashboard'].toscreen()),
    Key([super, shift], '2', lazy.group['Primary'].toscreen()),
    Key([super, shift], '3', lazy.group['Secondary'].toscreen()),
    Key([super, shift], '4', lazy.group['Coding'].toscreen()),
    Key([super, shift], '5', lazy.group['Virtual Machines'].toscreen()),
    Key([super, shift], '6', lazy.group['Gaming'].toscreen()),

    Key(hyper, '1', lazy.window.togroup('Dashboard')),
    Key(hyper, '2', lazy.window.togroup('Primary')),
    Key(hyper, '3', lazy.window.togroup('Secondary')),
    Key(hyper, '4', lazy.window.togroup('Coding')),
    Key(hyper, '5', lazy.window.togroup('Virtual Machines')),
    Key(hyper, '6', lazy.window.togroup('Gaming')),

    # Screen Split Navigation
    Key([super], 'o', lazy.layout.next_split()),
    Key([super], 'y', lazy.layout.previous_split()),
    Key([super, alt], 'o', lazy.layout.move_window_to_next_split()),
    Key([super, alt], 'y', lazy.layout.move_window_to_previous_split()),

    # Layout control
    Key(hyper, space, lazy.next_layout()),
    Key(hyper, 'm', lazy.layout.toggle_split()),

    Key(hyper, 'h', lazy.layout.shuffle_left()),  # Hackish way to add columns
    Key(hyper, 'l', lazy.layout.shuffle_right()),

    # Window - change focus
    Key([super], 'k', lazy.layout.up()),
    Key([super], 'j', lazy.layout.down()),
    Key([super], 'h', lazy.layout.left()),
    Key([super], 'l', lazy.layout.right()),

    # Window - move
    Key([super, alt], 'k', lazy.layout.shuffle_up()),
    Key([super, alt], 'j', lazy.layout.shuffle_down()),
    # The shuffle_* methods have the undesired behavior of collapsing a window into the adjacent column.
    Key([super, alt], 'h', lazy.layout.swap_column_left()),
    Key([super, alt], 'l', lazy.layout.swap_column_right()),

    # Window - resize
    Key([super, ctrl], 'k', lazy.layout.grow_up()),
    Key([super, ctrl], 'j', lazy.layout.grow_down()),
    Key([super, ctrl], 'h', lazy.layout.grow_left()),
    Key([super, ctrl], 'l', lazy.layout.grow_right()),
    Key(hyper, 'n', lazy.layout.normalize()),

    # Multimedia
    Key([], "XF86AudioLowerVolume", lazy.spawn("pactl set-sink-volume 0 -5%")),
    Key([], "XF86AudioRaiseVolume", lazy.spawn("pactl set-sink-volume 0 +5%")),
    Key([], "XF86AudioMute", lazy.spawn("pactl set-sink-mute 0 toggle")),

    # Floating
    Key([super, shift], 'm', lazy.window.toggle_fullscreen()),
    Key(hyper, 'f', lazy.window.toggle_floating()),
    # Key([], "", lazy.window.center())
    # Key([], "", lazy.function(float_to_front))

    # Scratchpads
    Key([super, alt], enter, lazy.group['Scratchpad'].dropdown_toggle('Terminal')),
    Key([super, alt], 'm', lazy.group['Scratchpad'].dropdown_toggle('VPN')),
]

