from typing import DefaultDict, TypedDict


class WindowPosition(TypedDict):
    x: float
    y: float
    height: float
    width: float


class DropDownConfig(DefaultDict):
    x: float = 0.1
    y: float = 0.0
    height: float = 0.35
    width: float = 0.8
    on_focus_lost_hide: bool = True
    opacity: float = 0.9
    warp_pointer: bool = True
