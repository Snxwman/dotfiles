# ruff: noqa: F403, F405

from typing import Any

from libqtile.bar import CALCULATED, Obj
from libqtile.widget.base import _Widget

from core.bar.icons import *
from core.bar.base import base, rectangle, use_symbol_font
from extras import Clock, GroupBox, TextBox, modify, widget
from utils.config import cfg
from utils.palette import palette, flexoki

DEFAULT_BG = f'{flexoki.base}DD'
DEFAULT_TEXT_FG = flexoki.text
DEFAULT_TEXT_SUB_FG = flexoki.base_500

# TODO: Standardized/configurable defaults
#  - Font and font size
#  - Colors


# TODO: All widgets
#  - Make proper types
#  - Type annotate functions
#  - Write doc strings


def bluetooth(
        icon: str = BT_ICON,
        icon_bg: str | None = DEFAULT_BG, 
        icon_fg: str = DEFAULT_TEXT_FG,
        text_bg: str | None = DEFAULT_BG,
        text_fg: str = DEFAULT_TEXT_FG,
        decorations: dict[str, Any] | None = None,
    ) -> list[_Widget]:
    """"""

    decorations = {} if decorations is None else decorations

    icon_widget = modify(
        TextBox,
        **base(icon_bg, icon_fg),
        **use_symbol_font(),
        **decorations,
        text = icon,
        initialise = True
    )

    return [icon_widget]


def bluetooth_battery(
        icon: str = MOUSE_ICON,
        icon_bg: str | None = DEFAULT_BG, 
        icon_fg: str = DEFAULT_TEXT_FG,
        text_bg: str | None = DEFAULT_BG,
        text_fg: str = DEFAULT_TEXT_FG,
        device: str = '',
        default_fmt: str = '',
        device_fmt: str = '{battery_level}',
        battery_fmt: str = '{battery}%',
        decorations: dict[str, Any] | None = None,
    ) -> list[_Widget]:
    """"""

    decorations = {} if decorations is None else decorations

    icon_widget = modify(
        TextBox,
        **base(icon_bg, icon_fg),
        **use_symbol_font(),
        **decorations,
        text = icon,
        initialise = True
    )


    battery = widget.Bluetooth(
        **base(text_bg, text_fg),
        **decorations,
        default_text = default_fmt,
        default_show_battery = True,
        device = device,
        device_format = device_fmt,
        device_battery_format = battery_fmt,
    )

    return [icon_widget, battery]


def clock(
        icon: str = CLOCK_ICON,
        icon_bg: str | None = DEFAULT_BG, 
        icon_fg: str = DEFAULT_TEXT_FG,
        text_bg: str | None = DEFAULT_BG,
        text_fg: str = DEFAULT_TEXT_FG,
        fmt: str = '%A, %B %-d - %-I:%M %p',
        long_format: str = 'Week %W, Day %-j, %Y',
        decorations: dict[str, Any] | None = None,
    ) -> list[_Widget]:
    """"""

    decorations = {} if decorations is None else decorations
    decorations = rectangle()

    icon_widget = TextBox(
        **base(icon_bg, icon_fg),
        **use_symbol_font(),
        **decorations,
        text = icon,
    )

    clock = Clock(
        **base(text_bg, text_fg),
        **decorations,
        format = fmt,
        long_format = long_format,
    )

    return [icon_widget, clock]


def cpu(
        icon: str = CPU_ICON,
        icon_bg: str | None = DEFAULT_BG, 
        icon_fg: str = DEFAULT_TEXT_FG,
        text_bg: str | None = DEFAULT_BG,
        text_fg: str = DEFAULT_TEXT_FG,
        alert_fg: str = flexoki.red,
        load_fmt: str = '{load_percent:.0f}%',
        temp_fmt: str = '{temp:.0f}{unit}',
        sensor: str = 'Tctl',
        alert_threshold: int = 70,
        use_metric: bool = True,
        update_interval: int = 2,
        powerline_fmt: str = 'arrow_right',  # TODO:
        decorations: dict[str, Any] | None = None,
        cpu_load_kwargs: dict[str, Any] | None = None,
        cpu_temp_kwargs: dict[str, Any] | None = None,
    ) -> list[_Widget]:
    """A compound widget containing an icon, the CPU load, and CPU temperature."""

    decorations = {} if decorations is None else decorations
    cpu_load_kwargs = {} if cpu_load_kwargs is None else cpu_load_kwargs
    cpu_temp_kwargs = {} if cpu_temp_kwargs is None else cpu_temp_kwargs

    icon_widget = widget.TextBox(
        **base(icon_bg, icon_fg),
        **use_symbol_font(),
        **decorations,
        text = icon,
    )

    cpu_load = widget.CPU(
        **base(text_bg, text_fg),
        **decorations,
        format = load_fmt,
        **cpu_load_kwargs,
    )

    cpu_temp = widget.ThermalSensor(
        **base(text_bg, text_fg),
        **decorations,
        format = temp_fmt,
        threshold = alert_threshold,
        foreground_alert = alert_fg,
        tag_sensor = sensor,
        metric = use_metric,
        update_interval = update_interval,
        **cpu_temp_kwargs,
    )

    return [icon_widget, cpu_load, cpu_temp]


def disk(
        icon: str = SSD_ICON,
        icon_bg: str | None = DEFAULT_BG, 
        icon_fg: str = DEFAULT_TEXT_FG,
        text_bg: str | None = DEFAULT_BG,
        text_fg: str = DEFAULT_TEXT_FG,
        warn_fg: str = DEFAULT_TEXT_FG,
        partition: str = '/',
        fmt: str = '{f}G',
        unit: str = 'G',
        update_interval: int = 5,
        always_show: bool = True,
        decorations: dict[str, Any] | None = None,
        disk_kwargs: dict[str, Any] | None = None,
    ) -> list[_Widget]:
    
    decorations = {} if decorations is None else decorations
    disk_kwargs = {} if disk_kwargs is None else disk_kwargs

    icon_widget = TextBox(
        **base(icon_bg, icon_fg),
        **use_symbol_font(),
        **decorations,
        text = icon,
    )

    disk = widget.DF(
        **base(text_bg, text_fg),
        **decorations,
        format = fmt,
        measure = unit,
        partition = partition,
        warn_color = warn_fg,
        update_interval = update_interval,
        visible_on_warn = not always_show,
        **disk_kwargs
    )

    return [icon_widget, disk]


# TODO:
#  - Refactor out colors to make it generic
def groups(
        bg: str | None = DEFAULT_BG, 
        colors: list[str] | None = None,
        highlight_color: str | None = None,
        inactive_color: str = flexoki.base_600,
        highlight_method: str = 'line',
        invert: bool = True,
        rainbow: bool = True,
        borderwidth: int = 2,
        padding: int = 4,
    ) -> GroupBox:
    """"""

    highlight_color = '#00000000' if highlight_color is None else highlight_color

    # QUESTION: Attach colors to groups?
    if colors is None:
        colors = [
            flexoki.yellow,
            flexoki.green,
            flexoki.blue,
            flexoki.orange,
            flexoki.purple,
            flexoki.magenta,
        ]

    return GroupBox(
        **use_symbol_font(14),
        **rectangle(),
        background = bg,
        colors = colors,
        borderwidth = borderwidth,
        highlight_color = highlight_color,
        inactive = inactive_color,
        highlight_method = highlight_method,
        invert = invert,
        rainbow = rainbow,
        padding = padding,
    )


def layout() -> list[_Widget]:
    """A combined wiget containing the current layout icon and name"""
    layout_icon = widget.CurrentLayoutIcon(
    )

    layout_name = widget.CurrentLayout(
    )

    return [layout_icon, layout_name]


def logo(
        icon: str = QTILE_LOGO,
        icon_bg: str | None = DEFAULT_BG,
        icon_fg: str = DEFAULT_TEXT_FG,
        padding: int = 20,
    ) -> TextBox:
    """"""

    return TextBox(
        **base(icon_bg, icon_fg),
        **use_symbol_font(),
        **rectangle(group = False),
        text = icon,
        padding = padding,
        # mouse_callbacks={"Button1": lazy.restart()},
    )


def mem(
        icon: str = RAM_ICON,
        icon_bg: str | None = DEFAULT_BG, 
        icon_fg: str = DEFAULT_TEXT_FG,
        text_bg: str | None = DEFAULT_BG,
        text_fg: str = DEFAULT_TEXT_FG,
        fmt: str = '{MemUsed:.2f}{mm}',
        ram_unit: str = 'G',
        swap_unit: str = 'M',
        update_interval: int = 2,
        decorations: dict[str, Any] | None = None,
        ram_kwargs: dict[str, Any] | None = None,
    ) -> list[_Widget]:

    decorations = {} if decorations is None else decorations
    ram_kwargs = {} if ram_kwargs is None else ram_kwargs

    icon_widget = TextBox(
        **base(icon_bg, icon_fg),
        **use_symbol_font(),
        **decorations,
        text = icon,
    )

    memory = widget.Memory(
        **base(text_bg, text_fg),
        **decorations,
        format = fmt,
        measure_mem = ram_unit,
        measure_swap = swap_unit,
        update_interval = update_interval,
        **ram_kwargs
    )

    return [icon_widget, memory]


def sep(
        icon: str = SEP_SYMBOL, 
        icon_bg: str | None = None,
        icon_fg: str = DEFAULT_TEXT_SUB_FG,
        size: int = 12,
        offset: int = 0,
        padding: int = 10
    ) -> TextBox:
    """A separator widget that allows any char to be the separator."""

    return TextBox(
        **base(icon_bg, icon_fg),
        **use_symbol_font(size),
        text = icon,
        offset = offset,
        padding = padding,
    )


def updates(
        icon: str = UPDATE_ICON,
        icon_bg: str | None = DEFAULT_BG, 
        icon_fg: str = DEFAULT_TEXT_FG,
        text_bg: str | None = DEFAULT_BG,
        text_fg: str = DEFAULT_TEXT_FG,
        updates_fg: str = DEFAULT_TEXT_FG,
        initial_fmt: str = ' ',
        updates_fmt: str = '{updates}',
        no_updates_fmt: str = '0',
        cmd: str = ' ' if cfg.is_xephyr else 'checkupdates',
        update_interval: int = 900,  # 15 minutes
        decorations: dict[str, Any] | None = None,
        update_kwargs: dict[str, Any] | None = None,
    ) -> list[_Widget]:
    """"""

    decorations = {} if decorations is None else decorations
    update_kwargs = {} if update_kwargs is None else update_kwargs

    icon_widget = TextBox(
        **base(icon_bg, icon_fg),
        **use_symbol_font(),
        **decorations,
        text = icon,
    )

    updates = widget.CheckUpdates(
        **base(text_bg, text_fg),
        **decorations,
        colour_no_updates = text_fg,
        colour_have_updates = updates_fg,
        initial_text = initial_fmt,
        display_format = updates_fmt,
        no_update_string = no_updates_fmt,
        custom_command = cmd,
        update_interval = update_interval,
        **update_kwargs,
    )

    return [icon_widget, updates]


# TODO:
#  - Make the cmds arg a typeddict
def volume(
        icon: str = VOLUME_HIGH_ICON,
        icon_bg: str | None = DEFAULT_BG, 
        icon_fg: str = DEFAULT_TEXT_FG,
        text_bg: str | None = DEFAULT_BG,
        text_fg: str = DEFAULT_TEXT_FG,
        mute_fg: str = DEFAULT_TEXT_FG,
        volume_fmt: str = '{volume}%',
        mute_fmt: str = 'M',
        card_id: str | None = None,
        device: str = 'default',
        channel: str = 'Master',
        # emoji: bool = False,
        # emoji_list: list[str] | None = None,
        cmds: dict[str, str] | None = None,
        step: int = 5,  # Used in command, unlike normal widget
        update_interval: float = 0.1,
        decorations: dict[str, Any] | None = None,
        volume_kwargs: dict[str, Any] | None = None
    ) -> list[_Widget]:
    """"""

    decorations = {} if decorations is None else decorations
    volume_kwargs = {} if volume_kwargs is None else volume_kwargs

    # TODO:
    #  - Extract commands to a provider object
    #  - Find a nicer way to interact with wireplumber
    #  - Make commands for get_volume and check_mute
    if cmds is None:
        cmds = {
            'get_volume_command': 'pamixer --get-volume-human',
            'volume_up_command': f'wpctl set-volume @DEFAULT_AUDIO_SINK@ {step}%+',
            'volume_down_command': f'wpctl set-volume @DEFAULT_AUDIO_SINK@ {step}%-',
            'check_mute_command': 'pamixer --get-mute',
            'mute_command': 'wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle',
        }

    icon_widget = modify(
        TextBox,
        **base(icon_bg, icon_fg),
        **use_symbol_font(),
        **decorations,
        text = icon,
        initialise = True
    )

    volume_widget = widget.Volume(
        **base(text_bg, text_fg),
        **decorations,
        mute_forground = mute_fg,
        unmute_format = volume_fmt,
        mute_format = mute_fmt,
        cardid = card_id,
        device = device,
        channel = channel,
        check_mute_string = 'true',
        update_interval = update_interval,
        **cmds,
        **volume_kwargs
    )

    return [icon_widget, volume_widget]


def wifi(
        icon: str = NET_WIFI_ICON,
        icon_bg: str | None = DEFAULT_BG, 
        icon_fg: str = DEFAULT_TEXT_FG,
        text_bg: str | None = DEFAULT_BG,
        text_fg: str = DEFAULT_TEXT_FG,
        fmt: str = "{essid} {percent:2.0%}",
        interface: str = 'wlan0',
        update_interval: int = 5,
        decorations: dict[str, Any] | None = None,
        wifi_kwargs: dict[str, Any] | None = None
    ) -> list[_Widget]:

    decorations = {} if decorations is None else decorations
    wifi_kwargs = {} if wifi_kwargs is None else wifi_kwargs

    icon_widget = TextBox(
        **base(icon_bg, icon_fg),
        **use_symbol_font(),
        **decorations,
        text = icon,
    )

    wifi = widget.Wlan(
        **base(text_bg, text_fg),
        **decorations,
        format = fmt,
        interface = interface,
        update_interval = update_interval,
        **wifi_kwargs
    )

    return [icon_widget, wifi]


def window_name(
        text_fg: str = DEFAULT_TEXT_FG,
        fmt: str = '{name}',
        max_chars: int = 150,
        width: Obj = CALCULATED,
    ) -> widget.WindowName:
    """"""

    return widget.WindowName(
        **base(None, text_fg),
        format = fmt,
        max_chars = max_chars,
        width = width,
    )

