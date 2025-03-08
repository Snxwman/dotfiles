# pyright: reportUnusedImport=false
# ruff: noqa: F401

from datetime import datetime as dt
from enum import Enum, auto
from pathlib import Path
from pprint import pprint
from typing import *

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
import tomllib
import unicodedata
import uuid
import xml
import zipfile
import zlib
import zoneinfo

console = None  # Placeholder for a Rich Console object
thrid_party_modules: list[tuple[str, str]] = [  # (module name, pypi name)
    ('dotenv', 'python-dotenv'),
    ('orjson', 'orjson'),
    ('requests', 'requests'),
    ('tomlkit', 'tomlkit'),
]
__imported_third_party_modules: list[str] = []

def try_pip_install(pypi_name: str):
    _ = subprocess.run([sys.executable, '-m', 'pip', 'install', pypi_name],
                   stdout=subprocess.DEVNULL,
                   stderr=subprocess.STDOUT)


def try_import_or_install_third_party_module(module: tuple[str, str]):
    module_name = module[0]
    pypi_name = module[1]

    try:
        __import__(module_name)
        __imported_third_party_modules.append(module_name)
    except ImportError:
        log = rich.print if console else print
        get_fmts = lambda fmt: (fmt, '[/' + fmt[1:]) if console else ('', '')

        fmt: tuple[str, str] = get_fmts('[bold yellow]')
        log(f'{fmt[0]}Failed to import {module_name}.{fmt[1]} Attempting `pip install {pypi_name}`...')

        try_pip_install(pypi_name)

        try:
            __import__(module_name)
            __imported_third_party_modules.append(module_name)
            fmt = get_fmts('[bold green]')
            log(f'{fmt[0]}Pip install succeeded. Imported {module_name}.{fmt[1]}')
        except ImportError:
            fmt = get_fmts('[bold red]')
            log(f'{fmt[0]}Pip install failed. Manual install required.{fmt[1]}')


# Upgrage pip itself
_ = subprocess.run([sys.executable, '-m', 'pip', '--upgrade', 'pip'],
                   stdout=subprocess.DEVNULL,
                   stderr=subprocess.STDOUT)

# Import or install rich first so it is available for nice logging asap
try_import_or_install_third_party_module(('rich', 'rich'))

try:
    from rich import pretty
    from rich.console import Console
    import rich
    import rich.pretty

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
