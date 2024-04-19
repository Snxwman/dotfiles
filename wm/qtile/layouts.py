from libqtile import layout
from libqtile.config import DropDown, Group, Match, ScratchPad
from libqtile.layout.columns import Columns

# Common theming for all layouts
black = '#1a1b26'
purple = '#9d7cd8'
green = '#9ece6a'
blue = '#7dcfff'
common_layout_theme = {
    'border_focus': '#9d7cd8',
    'border_normal': '#414868',
    'border_on_single': True,
    'border_width': 3,
    'margin': 5,
}

columns_layout_theme = {
    'border_focus_stack': '#7dcfff',
    'border_normal_stack': '#3d59a1',
    'grow_amount': 1.5,
    'insert_position': 1,  # "0 means right above the current window, 1 means right after"
    'num_columns': 3,
}
columns_layout_theme = dict(**common_layout_theme, **columns_layout_theme)

floating_layout_theme = {}
floating_layout_theme = dict(**common_layout_theme, **floating_layout_theme)

splits_2560 = [
    {
        'name': 'left',
        'rect': (0, 0, 0.25, 1),
        'layout': Columns(**columns_layout_theme),
    },
    {
        'name': 'middle',
        'rect': (0.25, 0, 0.5, 1),
        'layout': Columns(**columns_layout_theme),
    },
    {
        'name': 'right',
        'rect': (0.75, 0, 0.25, 1),
        'layout': Columns(**columns_layout_theme),
    },
]

splits_3440 = [
    {
        'name': 'left',
        'rect': (0, 0, 0.16, 1),
        'layout': Columns(**columns_layout_theme),
    },
    {
        'name': 'middle',
        'rect': (0.16, 0, 0.68, 1),
        'layout': Columns(**columns_layout_theme),
    },
    {
        'name': 'right',
        'rect': (0.84, 0, 0.16, 1),
        'layout': Columns(**columns_layout_theme),
    },
]
def init_layouts(): 
    layouts = [
        layout.ScreenSplit(name='2560', splits=splits_2560),
        layout.ScreenSplit(name='3440', splits=splits_3440),
        layout.Columns(**columns_layout_theme),
        layout.Floating(**floating_layout_theme),
    ]

    floating_layout = layout.Floating(
        float_rules=[
            *layout.Floating.default_float_rules,
            Match(wm_class='blueman-manager'),
            Match(wm_class='nemo'),
            Match(wm_class='galculator'),
            Match(title='vm_launcher'),
        ]
    )

    return layouts, floating_layout


def center_window(height, width):
    height = height if height > 0 else 0.05
    width = width if width > 0 else 0.05

    return {
        'x': (1-width) / 2,
        'y': (1-height) / 2,
        'height': height, 
        'width': width
    }

default_scratchpad_kwargs = {'on_focus_lost_hide': False, 'wrap_pointer': False, 'opacity': 1}
large_centered_kwargs = { **center_window(0.66, 0.26), **default_scratchpad_kwargs }
small_centered_kwargs = { **center_window(0.1, 0.3), **default_scratchpad_kwargs }
tiny_centered_kwargs = { **center_window(0, 0), **default_scratchpad_kwargs }

def init_groups(): 
    default_layout = 'columns'
    group_name = ['dashboard', 'main', 'alt', 'vms', 'gaming']
    #group_name = ['dash', 'main', 'alt', 'vm', 'windows']
    
    return [ 
        Group(group_name[0], layout=default_layout),
        Group(group_name[1], layout=default_layout),
        Group(group_name[2], layout=default_layout),
        Group(group_name[3], layout=default_layout),
        Group(group_name[4], layout=default_layout),

        ScratchPad('terminal', [
            DropDown('terminal', 'kitty --title scratchpad', **large_centered_kwargs),
        ])
    ]

