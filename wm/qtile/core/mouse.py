from libqtile.config import Click, Drag
from libqtile.lazy import lazy

from core.keybinds import super

left_click = 'Button1'
middle_click = 'Button2'
right_click = 'Button3'

mouse = [
    Drag(
        [super], left_click,
        lazy.window.set_position_floating(),
        start=lazy.window.get_position()
    ),
    Drag(
        [super], right_click,
        lazy.window.set_size_floating(),
        start=lazy.window.get_size()
    ),
    Click(
        [super], middle_click,
        lazy.window.bring_to_front()
    )
]  # fmt: skip 
