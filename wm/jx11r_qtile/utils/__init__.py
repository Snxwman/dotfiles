from typing import Any


def merge(*args: dict[str,Any] | list) -> dict[str,Any] | list:
    if all(isinstance(d, dict) for d in args):
        return {k: v for d in args for k, v in d.items()}  # type: ignore
    elif all(isinstance(l, list) for l in args):
        return [i for l in args for i in l]
    else:
        raise TypeError()

