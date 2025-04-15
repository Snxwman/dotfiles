from libqtile import layout

from utils import merge
from utils.match import wm_class
from utils.palette import palette, flexoki

config = {
    "border_focus": flexoki.green,
    "border_normal": flexoki.base_900,
    "border_width": 3,
    'border_on_single': True,
    "single_border_width": 3,
    "margin": 4,
    "single_margin": 4,
}

column_config = merge(
    config,
    {
        'border_focus_stack': flexoki.blue,
        'border_normal_stack': flexoki.base_600,
        'num_columns': 3,
        'grow_amount': 1.5,
        'insert_position': 1,  # "0 means right above the current window, 1 means right after"
    } 
)

layouts = [
    layout.Max(**config),
    layout.Columns(**column_config),  # pyright: ignore
]

floating_layout = layout.Floating(
    border_focus=flexoki.base_300,
    border_normal=flexoki.base_600,
    border_width=3,
    fullscreen_border_width=0,
    float_rules=[
        *layout.Floating.default_float_rules,
        *wm_class(
            "confirmreset",
            "Display",
            "floating",
            "ssh-askpass",
            "Xephyr",
            'blueman-manager',
            'nemo',
            'org.gnome.Nautilus',
            'gnome-calculator',
        ),
    ],
)
