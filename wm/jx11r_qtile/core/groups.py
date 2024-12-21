from libqtile.config import Group, ScratchPad

from core.scratchpad import scratchpad
from utils.match import wm_class, glob

groups: list[Group|ScratchPad] = [
    Group(
        name='Dashboard',
        label='󰕮',
        layout='max',
        position=0,
        screen_affinity=1,
        matches=wm_class('discord', 'spotify'),
        spawn='discord',
    ),
    Group(
        name='Primary',
        label='',
        layout='columns',
        position=1,
        screen_affinity=0,
    ),
    Group(
        name='Secondary',
        label='',
        position=2,
        layout='columns',
    ),
    Group(
        name='Coding',
        label='',
        layout='columns',
        position=3,
    ),
    Group(
        name='Virtual Machines',
        label='',
        layout='columns',
        position=4,
        matches=wm_class('virt-manager'),
        exclusive=True,
    ),
    Group(
        name='Gaming',
        label='',
        layout='max',
        position=5,
        init=False,
        persist=False,
        matches=wm_class('steam', glob('steam_app_')),
        exclusive=True,
    ),
    scratchpad
]

# for key, label, layout, matches in _groups:
#     groups.append(Group(key, matches, label=label, layout=layout))
#
#     keys.extend([
#         # mod1 + letter of group = switch to group
#         Key([mod], key, lazy.group[key].toscreen(toggle=True)),
#
#         # mod1 + shift + letter of group = move focused window to group
#         Key([mod, 'shift'], key, lazy.window.togroup(key)),
#     ])  # fmt: skip
