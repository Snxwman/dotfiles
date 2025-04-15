# import json
# from pathlib import Path
#
# from libqtile import hook, qtile
#
# class StateExporter:
#     default_state_file_path = '/tmp/test_qtile.state'
#     icons = {}
#
#     def __init__(self, state_file_path=default_state_file_path, icons=icons):
#         self.state_file = Path(state_file_path)
#
#         self.icons = icons
#         self.predefined_groups = ['dashboard', 'main', 'alt', 'vms', 'gaming']
#
#         self.full_state = {}
#         self.workspaces = []
#         self.scratchpads = []
#
#     def update_qtile_state(self):
#         self._screens = qtile.get_screens()
#         self._groups = qtile.get_groups()
#         self._windows = qtile.windows()
#         self._scratchpads = ['terminal', 'chat', 'utils']
#
#
#     @hook.subscribe.restart
#     @hook.subscribe.resume
#     @hook.subscribe.startup_complete
#     def get_full_state(self):
#         self.update_qtile_state()
#
#         for workspace_name, workspace_details in self._groups.items():
#             if workspace_name in self._scratchpads:
#                 scratchpad = {}
#                 self.scratchpads.append(dict(scratchpad))
#                 break
#
#             if workspace_name in self.icons['workspaces'].keys():
#                 workspace_icon = self.icons['workspaces'][workspace_name]
#             else:
#                 workspace_icon = self.icons['workspaces']['default']
#
#             workspace = {
#                 'name': workspace_name,
#                 # TODO: Need to get a list of current groups
#                 'number': 0,
#                 'icon': workspace_icon,
#                 'visible': False if workspace_details['screen'] is None else True,
#                 'screen': '' if workspace_details['screen'] is None else int(workspace_details['screen']),
#                 'layout': workspace_details['layout'],
#                 'is_temp': False if workspace_name in self.predefined_groups else True,
#                 'windows': [],
#                 'layouts': [],
#             }
#
#             for window_details in self._windows:
#                 if window_details['group'] == workspace_name:
#                     # c = CommandClient()
#                     # id = window_details['id']
#                     # visible = c.navigate("window", id).call("is_visible")
#                     window = {
#                         'name': window_details['name'],
#                         'icon': '',
#                         'focused': True if window_details['name'] == workspace_details['focus'] else False,
#                         'visible': '',
#                         'minimized': window_details['minimized'],
#                         'fullscreen': window_details['fullscreen'],
#                         'urgent_flag_set': False,
#                     }
#
#                     workspace['windows'].append(dict(window))
#
#             for layout_name in workspace_details['layouts']:
#                 if layout_name in self.icons['layouts'].keys():
#                     layout_icon = self.icons['layouts'][layout_name]
#                 else:
#                     layout_icon = self.icons['layouts']['default']
#                 layout = {
#                     'name': layout_name,
#                     'icon': ['layouts'][layout_name],
#                     'active': True if workspace_details['layout'] == layout_name else False,
#                 }
#                 workspace['layouts'].append(dict(layout))
#
#             self.workspaces.append(dict(workspace))
#
#         ...
#
#
#     @hook.subscribe.current_screen_change
#     @hook.subscribe.screen_change
#     @hook.subscribe.screens_reconfigured
#     @hook.subscribe.setgroup
#     def update_screens(self):
#         self.update_qtile_state()
#         ...
#
#
#     @hook.subscribe.changegroup
#     @hook.subscribe.group_window_add
#     @hook.subscribe.setgroup
#     def on_group_changed(self):
#         self.update_qtile_state()
#         ...
#
#
#     @hook.subscribe.addgroup
#     def on_group_added(self, group):
#         self.update_qtile_state()
#         ...
#
#
#     @hook.subscribe.delgroup
#     def on_group_deleted(self, group):
#         self.update_qtile_state()
#         ...
#
#
#     @hook.subscribe.group_window_add
#     def on_group_client_add(self, group, window):
#         self.update_qtile_state()
#         ...
#
#
#     @hook.subscribe.focus_change
#     def on_client_changed(self):
#         self.update_qtile_state()
#         ...
#
#
#     @hook.subscribe.client_focus
#     @hook.subscribe.client_mouse_entered
#     def on_client_focus_changed(self, client):
#         self.update_qtile_state()
#         ...
#
#
#     @hook.subscribe.client_killed
#     def on_client_killed(self, client):
#         self.update_qtile_state()
#         ...
#
#
#     @hook.subscribe.client_managed
#     def on_client_added(self, client):
#         self.update_qtile_state()
#         ...
#
#
#     @hook.subscribe.client_name_updated
#     def on_client_name_changed(self, client):
#         self.update_qtile_state()
#         ...
#
#
#     @hook.subscribe.client_urgent_hint_changed
#     def on_client_urgency_changed(self):
#         self.update_qtile_state()
#         ...
#
#
#     @hook.subscribe.new_wm_icon_change
#     def on_client_changed_icon(self, client):
#         self.update_qtile_state()
#         ...
#
#
#     @hook.subscribe.float_change
#     @hook.subscribe.layout_change
#     def update_layouts(self):
#         self.update_qtile_state()
#         ...
#
#
#     def write_state(self):
#         with self.state_file.open('w') as file:
#             file.write(json.dumps(self.full_state))
#
