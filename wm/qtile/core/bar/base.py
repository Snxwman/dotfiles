from importlib import import_module
from os import listdir
from os.path import isfile, join
from typing import Any

from libqtile import bar

from extras import PowerLineDecoration, RectDecoration
from utils.config import cfg


defaults = {
    'font': 'Iosevka Aile',
    'fontsize': 14,
    'padding': None,
}


class Bar:
    def __init__(self, theme: str) -> None:
        self.theme: str = theme


    @property
    def themes(self) -> set[str]:
        path = join(cfg.path(), 'core', 'bar')
        excluded_files = {'__init__.py', 'base.py'}
        return {
            file.removesuffix('.py')
            for file in listdir(path)
            if isfile(join(path, file)) and file not in excluded_files
        }


    @property
    def config(self) -> dict | None:
        if self.theme not in self.themes:
            return None
        module = import_module(f'core.bar.{self.theme}')
        return {'widgets': module.widgets(), **module.bar}


    def create(self) -> bar.BarType | None:
        if not self.config:
            return None
        return bar.Bar(**self.config)


def base(bg: str | None, fg: str) -> dict:
    return {
        'background': bg,
        'foreground': fg,
    }


# TODO: Refactor out font and fontsize into common config with normal font and fontsize
# QUESTION: Maybe make and Icon class that has the correct codepoint and font instead
def use_symbol_font(size: int | None = None) -> dict:
    if size is None:
        size = 16

    font = 'Symbols Nerd Font Mono'
    return {'font': font, 'fontsize': size}


def powerline(path: str | list[tuple], size: int=10):
    return { 
        'decorations': [
            PowerLineDecoration(
                path=path,
                size=size,
            )
        ]
    }


def rectangle(
        radius: int = 8,
        padding: int = 0,
        filled: bool = True,
        group: bool = True,
        rect_kwargs: dict[str, Any] | None = None
    ) -> dict[str, Any]:

    rect_kwargs = {} if rect_kwargs is None else rect_kwargs

    return { 
        'decorations': [
            RectDecoration(
                radius = radius,
                padding = padding,
                filled = filled,
                use_widget_background = True,
                group = group,
                **rect_kwargs
            )
        ]
    }
