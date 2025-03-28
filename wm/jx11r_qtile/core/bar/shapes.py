# pyright: reportArgumentType=false
# ruff: noqa: E731

from libqtile.bar import CALCULATED
from libqtile.widget.bluetooth import Bluetooth
from libqtile.widget.mpris2widget import Mpris2
from libqtile.widget.systray import Systray
from libqtile.widget.spacer import Spacer

from core.bar.base import base, powerline, rectangle, symbol
from extras import Clock, GroupBox, TextBox, modify, widget
from utils.config import cfg
from utils.palette import palette, flexoki


DISTRO_LOGO = ''
QTILE_LOGO = ''
SEP_SYMBOL = '󰇙'  # nf-md-dots_vertical

CPU_ICON = ''
RAM_ICON = ''
SSD_ICON = ''
GPU_ICON = '󰢮'
KB_ICON = '󰌌'
MOUSE_ICON = '󰍽'

BT_ICON = '󰂯'
BT_DISCOVER_ICON = '󰂱'
BT_OFF_ICON = '󰂲'

NET_DISCONNECTED_ICON = ''
NET_ETH_ICON = '󰈀'
NET_VPN_ICON = ''
NET_WIFI_ICON = ''
NET_WIFI_ICONS = [

]

UPDATE_ICON = ''

BAT_CHARGE_ICONS = [
    (('󰂎', ), ('󰢟', )),
    (('󰁺', ), ('󰢜', )),
    (('󰁻', ), ('󰂆', )),
    (('󰁼', ), ('󰂇', )),
    (('󰁽', ), ('󰂈', )),
    (('󰁾', ), ('󰢝', )),
    (('󰁿', ), ('󰂉', )),
    (('󰂀', ), ('󰢞', )),
    (('󰂁', ), ('󰂊', )),
    (('󰂂', ), ('󰂋', )),
    (('󰁹', ), ('󰂅', )),
]              

TEMP_LOW_ICON = ''
TEMP_NORMAL_ICON = ''
TEMP_HIGH_ICON = ''
TEMP_WARNING_ICON = ''
TEMP_C_ICON = '󰔄'
TEMP_F_ICON = '󰔅'

AUDIO_PLAY_ICON = ''
AUDIO_PAUSE_ICON = ''
AUDIO_STOP_ICON = ''
AUDIO_NEXT_ICON = ''
AUDIO_PREV_ICON = ''
AUDIO_SHUFFLE_ICON = ''
AUDIO_REPEAT_ICON = ''

VOLUME_MUTE_ICON = ''
VOLUME_OFF_ICON = ''
VOLUME_LOW_ICON = ''
VOLUME_MED_ICON = ''
VOLUME_HIGH_ICON = ''

MIC_ICON_ICON = ''
MIC_OFF_ICON = ''
CAM_ICON = '󰖠'
CAM_OFF_ICON = '󰖠'

NOTIF_ICON = ''
NOTIF_PENDING_ICON = '󱅫'
NOTIF_URGENT_ICON = '󰵙'
NOTIF_DND_ICON = ''

CLOCK_ICON = ''

KINESIS_KB_DBUS = '/org/bluez/hci0/dev_EE_4B_3D_BC_54_87'
LOGI_MOUSE_DBUS = '/org/bluez/hci0/dev_D5_17_8C_3E_76_FD'

bar = {
    "background": flexoki.blue_950,
    "border_color": flexoki.blue_950,
    "border_width": 4,
    "margin": [4, 4, 0, 4],  # South margin is 0 because it is set by the layout
    "opacity": 1,
    "size": 24,
}


def powerline_cap():
    ...


def sep(fg: str=palette.surface2, text: str=' ', offset: int=0, padding: int=10):
    return TextBox(
        **base(None, fg),
        **symbol(11),
        offset=offset,
        padding=padding,
        text=text,
    )

groups = lambda bg: GroupBox(
    **symbol(),
    background=bg,
    borderwidth=2,
    colors=[
        flexoki.yellow,
        flexoki.green,
        flexoki.blue,
        flexoki.orange,
        flexoki.purple,
        flexoki.magenta,
    ],
    highlight_color=flexoki.base,
    highlight_method="line",
    inactive=flexoki.base_600,
    invert=True,
    padding=6,
    rainbow=True,
)

# layout = lambda fg: [
#     
# ]

volume = lambda bg, fg: [
    modify(
        TextBox,
        **base(bg, fg),
        **symbol(),
        **rectangle("left"),
        offset=-17,
        padding=15,
        text=VOLUME_HIGH_ICON,
        x=-2,
    ),
    widget.Volume(
        **base(bg, fg),
        **powerline("arrow_right"),
        get_volume_command="pamixer --get-volume-human",
        volume_down_command="pamixer --decrease 5",
        volume_up_command="pamixer --increase 5",
        check_mute_command="pamixer --get-mute",
        mute_command="pamixer --toggle-mute",
        check_mute_string="true",
        update_interval=0.1,
    ),
]

updates = lambda bg, fg: [
    TextBox(
        **base(bg, fg),
        **symbol(14),
        **rectangle("left"),
        offset=-1,
        text=UPDATE_ICON,
        x=3,
    ),
    widget.CheckUpdates(
        **base(bg, fg),
        **powerline("arrow_right"),
        colour_have_updates=fg,
        colour_no_updates=fg,
        custom_command=" " if cfg.is_xephyr else "checkupdates",
        display_format=" {updates} updates  ",
        initial_text="  ",
        no_update_string=" No updates  ",
        padding=0,
        update_interval=3600,  # 15 minutes
    ),
]

window_name = lambda fg: widget.WindowName(
    **base(None, fg),
    format="{name}",
    max_chars=150,
    width=CALCULATED,
)

cpu = lambda bg, fg: [
    modify(
        TextBox,
        **base(bg, fg),
        **symbol(14),
        **rectangle("left"),
        offset=-13,
        padding=15,
        text=CPU_ICON,
    ),
    widget.CPU(
        **base(bg, fg),
        format="{load_percent:.0f}%",
    ),
    widget.ThermalSensor(
        **base(bg, fg),
        **powerline("arrow_right"),
        tag_sensor="Tctl",
        format="{temp:.0f}{unit}",
    )
]

ram = lambda bg, fg: [
    TextBox(
        **base(bg, fg),
        **symbol(14),
        offset=-1,
        padding=5,
        text=RAM_ICON,
    ),
    widget.Memory(
        **base(bg, fg),
        **powerline("arrow_right"),
        measure_mem="G",
        format="{MemUsed: .3}{mm} ",
        padding=-3,
    ),
]

disk = lambda bg, fg: [
    TextBox(
        **base(bg, fg),
        **symbol(14),
        offset=-1,
        text=SSD_ICON,
        x=-2,
    ),
    widget.DF(
        **base(bg, fg),
        **rectangle("right"),
        format="{f} GB  ",
        padding=0,
        partition="/",
        visible_on_warn=False,
        warn_color=fg,
    ),
]


group_left = lambda bg, fg: [
    TextBox(
        **base(bg, fg),
        **symbol(14),
        **rectangle('left'),
        offset=7,
        padding=0,
    ),
]

group_right = lambda bg, fg: [
    TextBox(
        **base(bg, fg),
        **symbol(14),
        **rectangle('right'),
        offset=7,
        padding=0,
    ),
]

bluetooth = lambda bg, fg: [
    TextBox(
        **base(bg, fg),
        **symbol(14),
        **rectangle('left'),
        offset=7,
        padding=0,
    ),
    TextBox(
        **base(bg, fg),
        **symbol(14),
        offset=0,
        padding=0,
        text=BT_ICON,
    ),
    TextBox(
        **base(bg, fg),
        **symbol(14),
        **powerline('arrow_right'),
        offset=0,
        padding=1,
    ),
]

bt_battery = lambda bg, fg, icon, device: [
    TextBox(
        **base(bg, fg),
        **symbol(14),
        offset=0,
        padding=4,
        text=icon,
    ),
    widget.Bluetooth(
        **powerline('arrow_right'),
        default_text='',
        default_show_battery=True,
        device=device,
        device_format='{battery_level}',
        device_battery_format='{battery}%',
        background=bg,
        foreground=fg,
        padding=5,
        hide_crash=True,
    ),
]

bt_battery_end = lambda bg, fg, icon, device: [
    TextBox(
        **base(bg, fg),
        **symbol(14),
        offset=0,
        padding=4,
        text=icon,
    ),
    widget.Bluetooth(
        default_text='',
        default_show_battery=True,
        device=device,
        device_format='{battery_level}',
        device_battery_format='{battery}%',
        background=bg,
        foreground=fg,
        padding=5,
        hide_crash=True,
    ),
    TextBox(
        **base(bg, fg),
        **symbol(14),
        **rectangle('right'),
        offset=0,
        padding=2,
    ),
]

clock = lambda bg, fg: [
    modify(
        TextBox,
        **base(bg, fg),
        **symbol(14),
        **rectangle("left"),
        offset=-14,
        padding=15,
        text=CLOCK_ICON,
    ),
    modify(
        Clock,
        **base(bg, fg),
        **rectangle("right"),
        fontsize=14,
        format="%A, %B %-d - %-I:%M %p",
        long_format="Week %W, Day %-j, %Y",
        padding=7,
    ),
]

wifi = lambda bg, fg: [ 
    TextBox(
        **base(bg, fg),
        **symbol(14),
        offset=-8,
        text=NET_WIFI_ICON,
        x=-2,
        y=-1,
    ),
    widget.Wlan(
        **base(bg, fg),
        **rectangle("right"),
        format="{essid} {percent:2.0%} ",
    ),
]

systray = lambda bg: [
    Systray(
        background=bg,
        icon_size=14,
        padding=7,
    )
]

logo = lambda bg, fg, img: TextBox(
    **base(bg, fg),
    **symbol(),
    **rectangle(),
    # mouse_callbacks={"Button1": lazy.restart()},
    padding=20,
    text=img,
)

logo_partial = lambda bg, fg, img, rect: TextBox(
    **base(bg, fg),
    **symbol(),
    **rect,
    # mouse_callbacks={"Button1": lazy.restart()},
    padding=20,
    text=img,
)

spacer = lambda bg, length: Spacer (
    background=bg,
    length=length,
    hide_crash=True,
)

# Flexoki
widgets = lambda: [
    logo(flexoki.blue, flexoki.base, QTILE_LOGO),
    sep(text=SEP_SYMBOL),

    groups(None),
    sep(text=SEP_SYMBOL),

    window_name(flexoki.text),
    widget.Spacer(),

    *clock(flexoki.blue_950, flexoki.text),
    widget.Spacer(),

    *cpu(flexoki.green_700, flexoki.base),
    *ram(flexoki.green_600, flexoki.base),
    *disk(flexoki.green_500, flexoki.base),
    sep(text=SEP_SYMBOL),

    *volume(flexoki.yellow_600, flexoki.base),
    *wifi(flexoki.yellow_400, flexoki.base),

    # spacer(flexoki.base, 16),
    sep(text=SEP_SYMBOL),
    *bluetooth(flexoki.blue_700, flexoki.base),
    *bt_battery(flexoki.blue_600, flexoki.base, KB_ICON, KINESIS_KB_DBUS),
    *bt_battery_end(flexoki.blue_500, flexoki.base, MOUSE_ICON, LOGI_MOUSE_DBUS ),
    sep(text=SEP_SYMBOL),

    # *systray(palette.blue),
    *updates(flexoki.base_600, flexoki.base),
    logo_partial(flexoki.blue, flexoki.base, DISTRO_LOGO, rectangle('right')),
]
