# pyright: reportArgumentType=false
# ruff: noqa: E731, F403, F405

from core.bar.base import rectangle
from core.bar.icons import *
from extras import widget
from utils.palette import palette, flexoki
import core.bar.widgets as w


KINESIS_KB_DBUS = '/dev_EE_4B_3D_BC_54_87'
LOGI_MOUSE_DBUS = '/dev_D5_17_8C_3E_76_FD'

# KINESIS_KB_DBUS = '/org/bluez/hci0/dev_EE_4B_3D_BC_54_87'
# LOGI_MOUSE_DBUS = '/org/bluez/hci0/dev_D5_17_8C_3E_76_FD'


bar = {
    # Add alpha channel to colors, using opacity makes widgets transparent too
    "background": f'{flexoki.blue_900}66',
    "border_color": f'{flexoki.blue_900}66',
    "border_width": 4,
    "margin": [4, 4, 0, 4],  # South margin is 0 because it is set by the layout
    "size": 24,
}


# window_name = lambda fg: widget.WindowName(
#     **base(None, fg),
#     format="{name}",
#     max_chars=150,
#     width=CALCULATED,
# )

decor = rectangle()

widgets = lambda: [
    w.logo(
        icon_bg = flexoki.blue,
        icon_fg = flexoki.base,
    ),
    w.sep(),

    w.groups(highlight_method='icon'),
    w.sep(),

    w.window_name(flexoki.text),
    widget.Spacer(),

    *w.clock(
        icon_bg = flexoki.blue_900,
        text_bg = flexoki.blue_900,
        decorations = decor
    ),
    widget.Spacer(),

    *w.cpu(icon_fg = flexoki.green, decorations = decor),
    *w.mem(icon_fg = flexoki.green, decorations = decor),
    *w.disk(icon_fg = flexoki.green, decorations = decor),
    w.sep(' ', size = 30, padding = 0),
    # w.sep(),

    # spacer(flexoki.base, 16),
    *w.bluetooth(icon_fg = flexoki.blue, decorations = decor),
    *w.bluetooth_battery(
        device = KINESIS_KB_DBUS,
        icon = KB_ICON,
        icon_fg = flexoki.blue,
        decorations = decor
    ),
    *w.bluetooth_battery(
        device = LOGI_MOUSE_DBUS,
        icon_fg = flexoki.blue,
        decorations = decor
    ),
    w.sep(' ', size = 30, padding = 0),

    *w.wifi(icon_fg = flexoki.cyan_l, decorations = decor),
    w.sep(' ', size = 30, padding = 0),

    *w.volume(icon_fg = flexoki.yellow, decorations = decor),
    w.sep(' ', size = 30, padding = 0),

    *w.updates(
        icon_fg = flexoki.blue_l,
        decorations = decor
    ),
    w.sep(),

    w.logo(
        icon = DISTRO_LOGO,
        icon_bg = flexoki.blue,
        icon_fg = flexoki.base,
    ),
]
