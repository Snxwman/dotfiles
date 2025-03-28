import re

from libqtile.config import Match


class Matches:
    def __init__(self, property: str):
        self.property: str = property

    def generate(self, values: tuple) -> list[Match]:
        return [Match(**{self.property: i}) for i in values]  # pyright: ignore


def wm_class(*values: str | re.Pattern) -> list[Match]:
    return Matches("wm_class").generate(values)


def glob(value: str) -> re.Pattern:
    return re.compile(value)


def title(*values: str) -> Match | list[Match]:
    matches = Matches("title").generate(values)

    if len(matches) == 1:
        return matches[0]
    else:
        return matches
