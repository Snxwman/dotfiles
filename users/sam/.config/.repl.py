# pyright: reportUnusedImport=false
# ruff: noqa: F401

import base64
import binascii
import bisect
import bz2
import collections
import copy
import csv
import datetime
import difflib
import enum
import filecmp
import functools
import gzip
import hashlib
import html
import http
import io
import ipaddress
import itertools
import json
import linecache
import lzma
import math
import os
import os.path
import pathlib
import pickle
import platform
import pwd
import random
import re
import readline
import secrets
import shutil
import socket
import sqlite3
import stat
import statistics
import string
import subprocess
import sys
import tarfile
import tempfile
import time
import timeit
import unicodedata
import uuid
import xml
import zipfile
import zlib
import zoneinfo
from datetime import datetime as dt
from enum import Enum, auto
from pathlib import Path
from pprint import pprint

import tomllib

console = None  # Placeholder for a Rich Console object
thrid_party_modules: list[tuple[str, str]] = [  # (module name, pypi name)
    ('dotenv', 'python-dotenv'),
    ('orjson', 'orjson'),
    ('requests', 'requests'),
    ('tomlkit', 'tomlkit'),
]
__imported_third_party_modules: list[str] = []


# INFO: from xdg-ninja
def is_vanilla() -> bool:
    """return whether running "vanilla" Python <3.13"""
    import sys

    return (
        not hasattr(__builtins__, '__IPYTHON__')  # pyright: ignore[reportAny]
        and 'bpython' not in sys.argv[0]
        and sys.version_info < (3, 13)
    )


# INFO: from xdg-ninja (with slight modifications)
def setup_history():
    """read and write history from state file"""
    import atexit
    import os
    import readline  # noqa: F811
    from pathlib import Path  # noqa: F811

    # NOTE: Added checking $HISTORY_DIR to support custom history file locations
    # NOTE: The XDG spec states that history files should go in $XDG_STATE_HOME
    #   by default: $HOME/.local/state.
    #   https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html#variables

    # Check PYTHON_HISTORY for future-compatibility with Python 3.13
    if python_history := os.environ.get('PYTHON_HISTORY'):
        history = Path(python_history)
    elif history_dir := os.environ.get('HISTORY_DIR'):
        history = Path(history_dir) / 'python'
    elif state_home := os.environ.get('XDG_STATE_HOME'):
        history = Path(state_home) / 'python_history'
    else:
        state_home = Path.home() / '.local' / 'state'
        history: Path = state_home / 'python_history'

    # WARN: Breaks on macos + python3 without this.
    # https://github.com/python/cpython/issues/105694
    if not history.is_file():
        readline.write_history_file(str(history))

    readline.read_history_file(history)
    _ = atexit.register(readline.write_history_file, history)


def try_pip_install(pypi_name: str):
    _ = subprocess.run(
        [sys.executable, '-m', 'pip', 'install', pypi_name],
        stdout=subprocess.DEVNULL,
        stderr=subprocess.STDOUT,
    )


def try_import_or_install_third_party_module(module: tuple[str, str]):
    module_name = module[0]
    pypi_name = module[1]

    try:
        __import__(module_name)
        __imported_third_party_modules.append(module_name)
    except ImportError:
        def get_fmts(fmt: str) -> tuple[str, str]:
            return (fmt, '[/' + fmt[1:]) if console else ('', '')

        log = rich.print if console else print  # TODO: Fix types
        fmt: tuple[str, str] = get_fmts('[bold yellow]')
        log(
            f'{fmt[0]}Failed to import {module_name}.{fmt[1]} Attempting `pip install {pypi_name}`...'
        )

        try_pip_install(pypi_name)

        try:
            __import__(module_name)
            __imported_third_party_modules.append(module_name)
            fmt = get_fmts('[bold green]')
            log(f'{fmt[0]}Pip install succeeded. Imported {module_name}.{fmt[1]}')
        except ImportError:
            fmt = get_fmts('[bold red]')
            log(f'{fmt[0]}Pip install failed. Manual install required.{fmt[1]}')


if is_vanilla():
    setup_history()

# Upgrage pip itself
_ = subprocess.run(
    [sys.executable, '-m', 'pip', '--upgrade', 'pip'],
    stdout=subprocess.DEVNULL,
    stderr=subprocess.STDOUT,
)

# Import or install rich first so it is available for nice logging asap
try_import_or_install_third_party_module(('rich', 'rich'))

try:
    import rich
    import rich.pretty
    from rich import pretty
    from rich.console import Console

    # Rebind Python's print and pprint
    __py_print = print
    __py_pprint = pprint
    # Bind Rich's versions to print and pprint
    print = rich.print
    pprint = pretty.pprint

    pretty.install()
    console = Console()
except ImportError:
    print('Failed to import rich.')

for module in thrid_party_modules:
    try_import_or_install_third_party_module(module)
