from libqtile.config import Screen

from core.bar import Bar
from utils.config import cfg

screens = [
    Screen(
        top=Bar(cfg.bar).create(),
        x11_drag_polling_rate=144
    ),
    Screen(
        x11_drag_polling_rate=144
    ),
]
