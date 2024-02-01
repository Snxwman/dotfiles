from logging import log
import os
import json
import subprocess
from typing import List  # noqa: F401

from libqtile import qtile, layout, bar, widget, hook
from libqtile.config import Click, Drag, Group, Key, Match, Screen, ScratchPad, DropDown
from libqtile.command import lazy
from libqtile.lazy import lazy
from libqtile.backend.x11 import window
from libqtile.confreader import ConfigError
from libqtile.widget import base
from libqtile.log_utils import logger
XEMBED_PROTOCOL_VERSION = 0

########################################################################################################################

from keybinds import init_keybinds
from layouts import init_groups, init_layouts
from mouse import init_mouse

# General config variables
auto_fullscreen = False
auto_minimize = False
bring_front_click = 'floating_only'
cursor_wrap = True                     # Default
dgroups_app_rules = []                  # Default
dgroups_key_binder = None               # Default
focus_on_window_activation = 'never'
follow_mouse_focus = True               # Default
reconfigure_screens = True              # Default
wmname = 'Qtile'

keys = init_keybinds()
layouts, floating_layout = init_layouts()
groups = init_groups()
mouse = init_mouse()

########################################################################################################################

# Paths and resources
icon_path = os.path.expanduser('~/.config/qtile/icons')
widget_icon_path = os.path.expanduser('~/.config/qtile/resources/icons/widgets')

qtile_logo = f'{icon_path}/qtile.png'
void_logo = f'{icon_path}/void.png'

# Fonts
default_font = 'Hermit Bold'
default_font_size = 12

widget_font = default_font
widget_font_size = default_font_size

widget_text_font = 'Ubuntu Mono'
widget_text_font_size = 37

widget_group_font = 'FontAwesome Bold'
widget_group_font_size = default_font_size

########################################################################################################################

colors = {
    'dark_base': '#1c1f24',
    'dark_alt': '#1f2428',
    'highlight': '#008080',
    'clock': '#d84949',
    'white': '#dfdfdf',
    'black': '#000000',
}

colors_other = [["#1f2428", "#1d2428"],
          ["#1c1f24", "#1c1f24"],
          ["#dfdfdf", "#dfdfdf"],
          ["#ff6c6b", "#ff6c6b"],
          ["#5f875f", "#5f875f"],
          ["#000000", "#000000"],
          ["#51afef", "#51afef"],
          ["#259ec1", "#259ec1"],
          ["#46d9ff", "#46d9ff"],
          ["#1f5b70", "#1f5b70"],
          ["#d84949", "#d84949"],
          ["#008080", "#008080"]]

widget_defaults = dict(
    font = widget_font,
    fontsize = widget_font_size,
    padding = 2,
    background = colors['white']
)
extension_defaults = widget_defaults.copy()

# Widgets
def init_widgets_list():
    right_triangle = ''
    triangle = ''
    
    spawn_terminal = lambda: qtile.cmd_spawn(terminal)
  
    separator_kwargs = {
        'linewidth': 0, 
        'background': colors['black'], 'foreground': colors['white']
    }
    text_box_kwargs = {
        'text': right_triangle, 
        'font': widget_text_font, 'fontsize': widget_text_font_size, 
        'padding': 0
    }
    text_box_alt_kwargs = {
        'text': triangle, 
        'font': widget_text_font, 'fontsize': widget_text_font_size, 
        'background': colors['black'], 'foreground': colors['black'], 
        'padding': 0
    }
    logo_kwargs = {
        'scale': 'False', 
        'background': colors['black'], 
        'mouse_callbacks': {'Button1': spawn_terminal}
    }
    clock_kwargs = {
        'format': "%A, %B %d - %l:%M %p", 
        'background': colors['dark_alt'], 'foreground': colors['clock'], 
        'padding': 5
    }
    systray_kwargs = {
        'background': colors['dark_alt'], 
        'padding': 5
    }
    window_name_kwargs = {
        'background': colors['black'], 'foreground': colors['white'], 
        'padding': 0
    }
    current_layout_icon_kwargs = {
        'custom_icon_paths': [widget_icon_path], 
        'background': colors['black'], 'foreground': colors['white'], 
        'padding': 6, 'scale': 0.7
    }
    current_layout_kwargs = {
        'background': colors['black'], 'foreground': colors['highlight'], 
        'padding': 5
    }
    group_box_kwargs = {
        'font': widget_group_font, 'fontsize': widget_group_font_size,
        'margin_y': 3, 'margin_x': 0, 'padding_y': 5, 'padding_x': 3,
        'borderwidth': 3, 'rounded': False,
        'active': colors_other[2], 'inactive': colors_other[11],
        'highlight_color': colors_other[1], 'highlight_method': 'line',
        'this_current_screen_border': colors_other[10], 'this_screen_border': colors_other[10],
        'other_current_screen_border': colors_other[6], 'other_screen_border': colors_other[10],
        'foreground': colors_other[2], 'background': colors_other[0]
    } 

    return [
        widget.Sep(padding = 10, **separator_kwargs),
        widget.Image(filename = qtile_logo, **logo_kwargs),
        widget.Sep(padding = 0, **separator_kwargs),
        widget.TextBox(background = colors['black'], foreground = colors['dark_alt'], **text_box_kwargs),
        widget.TextBox(background = colors['dark_alt'], foreground = colors['highlight'], **text_box_kwargs),
        widget.TextBox(background = colors['highlight'], foreground = colors['dark_alt'], **text_box_kwargs),
        widget.GroupBox(**group_box_kwargs),
        widget.TextBox(background = colors['dark_alt'], foreground = colors['black'], **text_box_kwargs),
        widget.CurrentLayoutIcon(**current_layout_icon_kwargs),
        widget.CurrentLayout(**current_layout_kwargs),
        widget.TextBox(**text_box_alt_kwargs),
        widget.WindowName(**window_name_kwargs),
        widget.TextBox(background = colors['black'], foreground = colors['dark_alt'], **text_box_kwargs),
        widget.Systray(**systray_kwargs),
        widget.Sep(linewidth = 0, background = colors['dark_alt'], foreground = colors['dark_alt'], padding = 6),
        widget.TextBox(background = colors['dark_alt'], foreground = colors['black'], **text_box_kwargs),
        widget.TextBox(background = colors['black'], foreground = colors['highlight'], **text_box_kwargs),
        widget.TextBox(background = colors['highlight'], foreground = colors['black'], **text_box_kwargs),
        widget.TextBox(background = colors['black'], foreground = colors['dark_base'], **text_box_kwargs),
        widget.TextBox(background = colors['dark_base'], foreground = colors['black'], **text_box_kwargs),
        widget.TextBox(background = colors['black'], foreground = colors['dark_alt'], **text_box_kwargs),
        widget.Clock(**clock_kwargs),
        widget.TextBox(background = colors['dark_alt'], foreground = colors['black'], **text_box_kwargs),
        widget.Image(filename = void_logo, **logo_kwargs),
        widget.Sep(linewidth = 0, background = colors['white'], foreground = colors['black'], padding = 0)
    ]


# Set bar to screen
def init_widgets_screen1():
    widgets_screen1 = init_widgets_list()
    return widgets_screen1


# Set bar height and opacity, also set wallpaper
def init_screens():
    return [Screen(top=None)]


# Initiate functions for screens and widgets
if __name__ in ["config", "__main__"]:
    screens = init_screens()
    #widgets_list = init_widgets_list()
    #widgets_screen1 = init_widgets_screen1()

@hook.subscribe.startup_once
def start_eww():
    subprocess.run("~/.scripts/start_eww", shell=True)

@hook.subscribe.startup_once
@hook.subscribe.layout_change
@hook.subscribe.client_new
@hook.subscribe.changegroup
@hook.subscribe.focus_change
async def _(*args):    
    eww_bin = '/opt/eww'
    state = []

    scratchpads = ['terminal', 'chat', 'utils']
    icons = {
        'dashboard': '󰕮',
        'main': '',
        'alt': '',
        'vms': '',
        'gaming': '',
        'columns': '',
        'floating': '',
        '0': '󰎣',
        '1': '󰎦',
        '2': '󰎩',
        '3': '󰎬',
        '4': '󰎮',
        '5': '󰎰'
    }

    qtile_groups = qtile.get_groups()

    for qtile_group_name, qtile_group_info in qtile_groups.items():
        if qtile_group_name not in scratchpads:

            screen_icon = None
            if (screen := qtile_group_info['screen']) is not None:
                screen_icon = icons[str(screen)]

            group = {
                'name': qtile_group_name,
                'icon': icons[qtile_group_name],
                'active': True if qtile_group_info['screen'] is not None else False,
                'open_window': True if len(qtile_group_info['windows']) >= 1 else False,
                'screen': screen,
                'screen_icon': screen_icon,
                'layout': qtile_group_info['layout'],
                'layout_icon': icons[qtile_group_info['layout']],
                'layouts': [{'name': l, 'icon': icons[l]} for l in qtile_group_info['layouts']],
            }

            state.append(dict(group))

    subprocess.run(f"{eww_bin} update wm-state='{json.dumps(state)}'", shell=True)
    subprocess.run(f"/opt/eww --config ~/src/github/rancid update wm-state='{json.dumps(state)}'", shell=True)

