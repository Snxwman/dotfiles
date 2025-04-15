import json
from dataclasses import asdict, dataclass
from os import getenv, getcwd
from os.path import exists, expanduser, join

# FIXME: Eliminate use of cfg.json
@dataclass
class Config:
    # FIXME: Change bar config to dict[int, str] meaning [screen, presetname]
    # Can this support defining bar widgets somewhere else?
    bar: str = 'shapes'
    bar2: str = ''
    browser: str = ''  # NOTE: Should these be expanded to their full path?
    term: str | None = ''
    term2: str = ''
    wallpaper: str = ''

    fonts = {
        'default': '',
        'default_mono': 'Berkeley Mono Regular',
        'defalut_symbol': 'Symbols Nerd Font Mono Regular',
        'widget': 'Hasklug Nerd Font Mono Medium',
        'widget_symbols': 'Symbol Nerd Font Mono Regular',
    }

    widgets = {
        'defaults': {
            'fontsize': 11,
            'padding': None,
        },
        'fontsize_symbols': 16,
    }


    commands = {
        'audio': {
            'get_volume': 'wpctl get-volume @DEFAULT_AUDIO_SINK@',
            'volume_up': '',
            'volume_down': '',
            'check_mute': '',
            'mute': '',
        }
    }

    @property
    def is_xephyr(self) -> bool:
        return bool(getenv('QTILE_XEPHYR'))
        # NOTE: Is this actually needed for some reason?
        # return int(environ.get('QTILE_XEPHYR', 0)) > 0

    @staticmethod
    def path() -> str:
        dirs = [
            f'{getenv('XDG_CONFIG_HOME')}/qtile',
            expanduser('~/.config/qtile/') 
        ]

        for dir in dirs:
            if exists(dir):
                return dir
        return getcwd()


    @classmethod
    def load(cls) -> 'Config':
        file = join(cls.path(), 'cfg.json')
        if not exists(file):
            cls.generate(file)
            return cls()
        with open(file, 'r') as f:
            content = json.load(f)
            return cls(**content)

    @classmethod
    def generate(cls, file: str):
        with open(file, 'w') as f:
            content = asdict(cls())
            f.write(json.dumps(content, indent=2))


cfg = Config.load()
