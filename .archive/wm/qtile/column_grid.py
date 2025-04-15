# from typing import TYPE_CHECKING
#
# if TYPE_CHECKING:
#     from typing import Any, Self
#
#     from libqtile.backend.base import Window
#     from libqtile.config import ScreenRect
#     from libqtile.group import _Group
#
# from libqtile.backend.base.window import Window
# from libqtile.command.base import expose_command
# from libqtile.layout.base import Layout, _ClientList
# from libqtile.log_utils import logger
#
# class _Column(_ClientList):
#
#     def __init__(self, split, insert_position, width=100):
#         _ClientList.__init__(self)
#         self.split = split
#         self.insert_position = insert_position
#         self.width = width
#         self.heights = {}
#
#     def add_client(self, client: Window, height=100):
#         ...
#
#     def remove_client(self):
#         ...
#
#     def split_vertically(self):
#         ...
#
#     def set_width(self):
#         ...
#
#
# class ColumnGrid(Layout):
#
#     _left = 0
#     _right = 1
#
#     defaults = [
#         ("border_focus", "#881111", "Border colour(s) for the focused window."),
#         ("border_normal", "#220000", "Border colour(s) for un-focused windows."),
#         (
#             "border_focus_stack",
#             "#881111",
#             "Border colour(s) for the focused window in stacked columns.",
#         ),
#         (
#             "border_normal_stack",
#             "#220000",
#             "Border colour(s) for un-focused windows in stacked columns.",
#         ),
#         ("border_width", 2, "Border width."),
#         ("single_border_width", None, "Border width for single window."),
#         ("border_on_single", False, "Draw a border when there is one only window."),
#         ("margin", 0, "Margin of the layout (int or list of ints [N E S W])."),
#         (
#             "margin_on_single",
#             None,
#             "Margin when only one window. (int or list of ints [N E S W])",
#         ),
#         ("split", True, "New columns presentation mode."),
#         ("num_columns", 2, "Preferred number of columns."),
#         ("grow_amount", 10, "Amount by which to grow a window/column."),
#         ("fair", False, "Add new windows to the column with least windows."),
#         (
#             "insert_position",
#             0,
#             "Position relative to the current window where new ones are inserted "
#             "(0 means right above the current window, 1 means right after).",
#         ),
#         ("wrap_focus_columns", True, "Wrap the screen when moving focus across columns."),
#         ("wrap_focus_rows", True, "Wrap the screen when moving focus across rows."),
#         ("wrap_focus_stacks", True, "Wrap the screen when moving focus across stacked."),
#         (
#             "align",
#             _right,
#             "Which side of screen new windows will be added to "
#             "(one of ``Columns._left`` or ``Columns._right``). "
#             "Ignored if 'fair=True'.",
#         ),
#         ("initial_ratio", 1, "Ratio of first column to second column."),
#     ]
#
#
#     def __init__(self, **config):
#         Layout.__init__(self, **config)
#         self.add_defaults(Columns.defaults)
#
#         if not self.border_on_single:
#             self.single_border_width = 0
#         elif self.single_border_width is None:
#             self.single_border_width = self.border_width
#
#         if self.margin_on_single is None:
#             self.margin_on_single = self.margin
#
#         self.columns = [_Column(self.split, self.insert_position)]
#         self.current = 0
#
#         if self.align not in (Columns._left, Columns._right):
#             logger.warning("Unexpected value for `align`. Must be Columns._left or Columns._right.")
#             self.align = Columns._right
#
#
#     @expose_command
#     def info(self) -> dict[str, Any]:
#         d = Layout.info(self)
#         d['clients'] = []
#         d['columns'] = []
#
#     def clone(self):
#         ...
#
#     def get_windows(self):
#         ...
#
#     def focus(self):
#         ...
#
#     def configure(self, client: Window, screen_rect: ScreenRect) -> None:
#         return super().configure(client, screen_rect)
#
#     @expose_command
#     def configure_preset(self):
#         ...
#
#     @expose_command
#     def equalize(self):
#         ...
#
#     @expose_command
#     def normalize(self):
#         ...
#
#     @expose_command
#     def add_column(self):
#         ...
#
#     @expose_command
#     def remove_column(self):
#         ...
#
#     def add_client(self):
#         ...
#
#     def remove_client(self):
#         ...
#
#     def wrap(self):
#         ...
#
#     @expose_command
#     def up(self):
#         ...
#
#     @expose_command
#     def down(self):
#         ...
#
#     @expose_command
#     def left(self):
#         ...
#
#     @expose_command
#     def right(self):
#         ...
#
#     @expose_command
#     def next(self):
#         ...
#
#     @expose_command
#     def previous(self):
#         ...
#
#     @expose_command
#     def toggle_split(self):
#         ...
#
#     @expose_command
#     def focus_first(self) -> Window | None:
#         return super().focus_first()
#
#     @expose_command
#     def focus_last(self) -> Window | None:
#         return super().focus_last()
#
#     @expose_command
#     def focus_next(self, win: Window) -> Window | None:
#         return super().focus_next(win)
#
#     @expose_command
#     def focus_previous(self, win: Window) -> Window | None:
#         return super().focus_previous(win)
#
#     @expose_command
#     def shuffle_up(self):
#         ...
#
#     @expose_command
#     def shuffle_down(self):
#         ...
#
#     @expose_command
#     def shuffle_left(self):
#         ...
#
#     @expose_command
#     def shuffle_right(self):
#         ...
#
#     @expose_command
#     def grow_up(self):
#         ...
#
#     @expose_command
#     def grow_down(self):
#         ...
#
#     @expose_command
#     def grow_left(self):
#         ...
#
#     @expose_command
#     def grow_right(self):
#         ...
#
#     def swap_column(self):
#         ...
#
#     @expose_command
#     def swap_column_left(self):
#         ...
#
#     @expose_command
#     def swap_column_right(self):
#         ...
#
