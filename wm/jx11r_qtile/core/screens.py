from libqtile.config import Screen

from core.bar import Bar
from utils.config import cfg

screens = [
    Screen(top=Bar(cfg.bar).create()),
    Screen(bottom=Bar(cfg.bar2).create()),
]
