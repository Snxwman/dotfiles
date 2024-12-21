from dataclasses import KW_ONLY, dataclass
from typing import TypedDict

from libqtile.config import DropDown, Match, ScratchPad

from utils.match import title


class DropDownConfigDict(TypedDict):
    match: Match | None
    on_focus_lost_hide: bool
    warp_pointer: bool
    opacity: float
    x: float
    y: float
    height: float
    width: float


@dataclass
class DropDownConfig:
    _: KW_ONLY
    match: Match | None = None
    on_focus_lost_hide: bool = True
    warp_pointer: bool = True
    opacity: float = 0.9
    x: float = 0.1
    y: float = 0.1
    height: float = 0.35
    width: float = 0.8


    def as_dict(self) -> DropDownConfigDict:
        return DropDownConfigDict(**self.__dict__)  # type: ignore


# TODO: Find a way to set a minimum size based on screen size
def center_window(width: float=0.5, height: float=0.5):
    """Calculates the initial position, and size of a window that should be centered"""

    # min_height = 1000.0 / qtile.current_screen.height
    # min_width = 1400.0 / qtile.current_screen.width

    # height = max(height, min_height, 0.05)
    # width = max(width, min_width, 0.05)
    x = round((1 - width) / 2, 2)
    y = round((1 - height) / 2, 2)
    width = max(width, 0.05)
    height = max(height, 0.05)

    # self.x = (1-width) / 2
    # self.y = (1-height) / 2
    # self.height = height
    # self.width = width 

    return {
        'x': x,
        'y': y,
        'width': width,
        'height': height,
    }


@dataclass
class GhosttyLaunchConfig:
    # Launch arguments for ghostty
    # The bin key is the program that will be run (it must accept the flags specified)
    # The env key is a dict of envvars that will be prepended as NAME=value (name is .upper()'ed)
    # The rest of the keys are exactly the ghostty flag names
    _: KW_ONLY
    bin: str | None = None
    env: list[tuple[str, str]] | None = None
    title: str | None = None
    wm_class: str | None = None
    x11_instance_name: str | None = None
    command: str | None = None
    initial_command: str | None = None
    wait_after_command: bool = False
    working_directory: str | None = None

    def flags(self) -> list[tuple[str, str]]:
        flags = list(
            (flag, arg) for flag, arg in [
                ('--title', self.title),
                ('--x11-instance-name', self.x11_instance_name),
                ('--command', self.command),
                ('--initial-command', self.initial_command),
                ('--working-directory', self.working_directory),
            ] if arg is str and arg is not None or arg == ''
        )

        if self.wait_after_command is True:
            flags.append(('--wait-after-command', ''))

        return flags


    # TODO: Make return type a QtileSpawnDict
    def spawn(self):
        # Hardcoded because these are the launch options specifically for ghostty
        bin = self.bin if self.bin is not None else 'ghostty'

        flags = ''
        if self.flags:
            flags = ' '.join([f'{flag}="{arg}"' for flag, arg in self.flags()])

        env = ''
        if self.env:
            for k,v in self.env:
                env += f'{k.upper()}={v} '

        return f'{env} {bin} {flags}'.strip()
        # return {
        #     'cmd': f'{bin} {flags}'.strip(),
        #     'env': self.env
        # }


base_dropdown_config = { 
    'on_focus_lost_hide': False,
    'warp_pointer': False,
    'opacity': 1
}

# BUG: Qtile only accepts a string for a dropdown's launch command, instead of the args for spawn().
#      However, the string is still given to spawn() as its `cmd` which expects that to be an executable.
#      Since we cannot provide `env` to spawn() through DropDown(), we must have ghostty reexec the shell 
#          with the desired env after the shell is already loaded.
ghostty_config = GhosttyLaunchConfig(
    bin='/usr/bin/ghostty',
    # env=[
    #     ('SCRATCHPAD', 'true')
    # ],
    command="SCRATCHPAD= zsh"
)
terminal_config = DropDownConfig(
    **base_dropdown_config,  # type: ignore
    **center_window(0.3, 0.7)
).as_dict()

mullvad_app = '/opt/Mullvad\\ VPN/mullvad-vpn'
mullvad_config = DropDownConfig(
    on_focus_lost_hide=False,
    opacity=1,
    warp_pointer=True,
    # TODO: Split the single and multiple functions up
    match=title('Mullvad VPN'),  # type: ignore
    **center_window(0.0625, 0.3944)  # type: ignore
).as_dict()

scratchpad = ScratchPad('Scratchpad', [
    DropDown('Terminal', ghostty_config.spawn(), **terminal_config),
    DropDown('VPN', mullvad_app, **mullvad_config),
])

