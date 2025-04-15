import os
import json
import subprocess

from libqtile import qtile, hook
from libqtile.lazy import lazy
from libqtile.config import Screen
from libqtile.command.client import CommandClient

########################################################################################################################

from keybinds import init_keybinds
from layouts import init_groups, init_layouts
from mouse import init_mouse

# General config variables
auto_fullscreen = False
auto_minimize = False
bring_front_click = 'floating_only'
cursor_wrap = True
dgroups_app_rules = []
dgroups_key_binder = None
focus_on_window_activation = 'smart'
follow_mouse_focus = True
reconfigure_screens = True
wmname = 'qtile'

keys = init_keybinds()
layouts, floating_layout = init_layouts()
groups = init_groups()
mouse = init_mouse()

########################################################################################################################

def init_screens():
    return [Screen(top=None)]


# Initiate functions for screens and widgets
if __name__ in ["config", "__main__"]:
    screens = init_screens()


# @hook.subscribe.startup_once
# def start_eww():
#     script = os.path.expanduser('~/.config/qtile/autostart.sh')
#     subprocess.run([script])


@hook.subscribe.startup_once
@hook.subscribe.layout_change
@hook.subscribe.client_new
@hook.subscribe.changegroup
@hook.subscribe.focus_change
def _(*args):
    state = []

    scratchpads = ['terminal', 'chat', 'utils']
    predefined = ['dashboard', 'main', 'alt', 'vms', 'gaming']

    icons = {
        'dashboard': '󰕮',
        'main': '',
        'alt': '',
        'vms': '',
        'gaming': '',
        '2560': '󰯌',
        '3440': '󰯌',
        'godot': 'G',
        'columns': '',
        'floating': '',
        '0': '󰎣',
        '1': '󰎦',
        '2': '󰎩',
        '3': '󰎬',
        '4': '󰎮',
        '5': '󰎰'
    }

    _icons = {
        'screens': {
            '0': '󰎣',
            '1': '󰎦',
            '2': '󰎩',
            '3': '󰎬',
            '4': '󰎮',
            '5': '󰎰',
            'default': '',
        },
        'workspaces': {
            'dashboard': '󰕮',
            'main': '',
            'alt': '',
            'coding': '',
            'vms': '',
            'gaming': '',
            'default': '',
        },
        'layouts': {
            '2560': '󰯌',
            '3440': '󰯌',
            'godot': 'G',
            'columns': '',
            'floating': '',
            'default': '',
        },
    }

    ##################################################
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

    with open('/tmp/qtile.state', 'a') as f:
        f.write(json.dumps(state) + '\n')
    ##################################################

    workspaces = []
    _scratchpads = []

    for workspace_name, workspace_details in qtile.get_groups().items():
        if workspace_name in scratchpads:
            scratchpad = {}
            _scratchpads.append(dict(scratchpad))
        else:
            try:
                icon = _icons['workspaces'][workspace_name]
            except KeyError:
                icon = ''

            workspace = {
                'name': workspace_name,
                'number': 0,    # TODO: Need to get a list of current groups
                'icon': icon,
                'visible': False if workspace_details['screen'] is None else True,
                'screen': '' if workspace_details['screen'] is None else int(workspace_details['screen']),
                'layout': workspace_details['layout'],
                'is_temp': False if workspace_name in predefined else True,
                'windows': [],  # TODO: Not finished
                'layouts': [],
            }

            for window_details in qtile.windows():
                if window_details['group'] == workspace_name:
                    # c = CommandClient()
                    # id = window_details['id']
                    # visible = c.navigate("window", id).call("is_visible")
                    window = {
                        'name': window_details['name'],
                        'icon': '',
                        'focused': True if window_details['name'] == workspace_details['focus'] else False,
                        'visible': '',
                        'minimized': window_details['minimized'],
                        'fullscreen': window_details['fullscreen'],
                        'urgent_flag_set': False,
                    }

                    workspace['windows'].append(dict(window))

            for layout_name in workspace_details['layouts']:
                layout = {
                    'name': layout_name,
                    'icon': _icons['layouts'][layout_name],
                    'active': True if workspace_details['layout'] == layout_name else False,
                }
                workspace['layouts'].append(dict(layout))

            workspaces.append(dict(workspace))

    _state = {'workspaces': workspaces, 'scratchpads': scratchpads}

    with open('/tmp/_qtile.state', 'w') as f:
        f.write(json.dumps(_state))

    # subprocess.run(f"/opt/eww update wm-state='{json.dumps(state)}'", shell=True)

    # subprocess.run(f"/opt/eww --config ~/.config/rancid/ update wm-state='{json.dumps(state)}'", shell=True)

    # subprocess.run(f"/opt/eww --config ~/src/github/rancid/.test/ update wm-state='{json.dumps(state)}'", shell=True)

