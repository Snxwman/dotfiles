from typing import Any


def merge(*args: dict[str, Any] | list[Any]) -> dict[str, Any] | list[Any]:
    if all(isinstance(d, dict) for d in args):
        return merge_dict(*args)  # pyright: ignore
    elif all(isinstance(l, list) for l in args):
        return merge_list(*args)  # pyright: ignore
    else:
        raise TypeError()

def merge_dict(*args: dict[str, Any]) -> dict[str, Any]:
    return {k:v for d in args for k,v in d.items()}

def merge_list(*args: list[Any]) -> list[Any]:
    return [i for l in args for i in l]

