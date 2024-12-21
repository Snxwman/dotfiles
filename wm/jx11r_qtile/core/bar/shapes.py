from libqtile.bar import CALCULATED

from core.bar.base import base, powerline, rectangle, symbol
from extras import Clock, GroupBox, TextBox, modify, widget
from utils.config import cfg
from utils.palette import palette

bar = {
    "background": palette.base,
    "border_color": palette.base,
    "border_width": 4,
    "margin": [7, 10, 0, 10],
    "opacity": 1,
    "size": 24,
}


def sep(fg=palette.surface2, text=' ', offset=0, padding=10):
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
    borderwidth=1,
    colors=[
        palette.teal,
        palette.pink,
        palette.yellow,
        palette.red,
        palette.blue,
        palette.green,
    ],
    highlight_color=palette.base,
    highlight_method="line",
    inactive=palette.surface2,
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
        text="",
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
        text="",
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
        update_interval=3600,
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
        text="󰍛",
    ),
    widget.CPU(
        **base(bg, fg),
        **powerline("arrow_right"),
        format="{load_percent:.0f}%",
    ),
]

ram = lambda bg, fg: [
    TextBox(
        **base(bg, fg),
        **symbol(14),
        offset=-1,
        padding=5,
        text="",
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
        text="",
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

clock = lambda bg, fg: [
    modify(
        TextBox,
        **base(bg, fg),
        **symbol(14),
        **rectangle("left"),
        offset=-14,
        padding=15,
        text="",
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
        text="",
        x=-2,
        y=-1,
    ),
    widget.Wlan(
        **base(bg, fg),
        **rectangle("right"),
        format="{essid} {percent:2.0%} ",
    ),
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

widgets = lambda: [
    logo(palette.blue, palette.base, ''),
    sep(text='󰇙'),
    groups(None),
    sep(text='󰇙'),
    # sep(palette.surface2),
    window_name(palette.text),
    widget.Spacer(),
    *clock(palette.base, palette.text),
    widget.Spacer(),
    *cpu(palette.green, palette.base),
    *ram(palette.yellow, palette.base),
    *disk(palette.teal, palette.base),
    sep(text='󰇙'),
    *volume(palette.pink, palette.base),
    *wifi(palette.red, palette.base),
    sep(text='󰇙'),
    *updates(palette.overlay2, palette.base),
    logo_partial(palette.blue, palette.base, '', rectangle('right')),
]
