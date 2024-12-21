from libqtile import layout

from utils import merge
from utils.match import wm_class
from utils.palette import palette

config = {
    "border_focus": palette.pink,
    "border_normal": palette.base,
    "border_width": 3,
    'border_on_single': True,
    "single_border_width": 3,
    "margin": 5,
    "single_margin": 5,
}

column_config = merge(
    config,
    {
        'border_focus_stack': palette.sapphire,
        'border_normal_stack': palette.surface0,
        'num_columns': 3,
        'grow_amount': 1.5,
        'insert_position': 1,  # "0 means right above the current window, 1 means right after"
    } 
)

layouts = [
    # layout.monadtall(
    #     **config,
    #     change_ratio=0.02,
    #     min_ratio=0.30,
    #     max_ratio=0.70,
    # ),
    layout.Max(**config),
    layout.Columns(**column_config),  # type: ignore
]

floating_layout = layout.Floating(
    border_focus=palette.subtext1,
    border_normal=palette.base,
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
        # *title(
        #     "pinentry",
        # ),
    ],
)
