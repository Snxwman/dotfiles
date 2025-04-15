from abc import ABC, abstractmethod


class ThemeColor:

    def __init__(self):
        border_normal = ''
        border_normal_stack = ''
        border_focus = ''
        border_focus_stack = ''


class ThemeLayout:
    ...


class ThemeInstance(ABC):

    @property
    @abstractmethod
    def name(self) -> str:
        pass


    @property
    @abstractmethod
    def author(self) -> str:
        pass

    @property
    @abstractmethod
    def repo_url(self) -> str:
        pass
    

    @abstractmethod
    def named_colors(self) -> dict[str, str]:
        """The internal names of the theme's colors

        Example:
        { 'blue_light': '#7dcfff' }
        """
        pass


    @abstractmethod
    def colors(self) -> ThemeColor:
        """A Qtile layout's color properties mapped to their internal name
        
        Example:
        { 'border_normal': blue_light }
        """
        pass


    @abstractmethod
    def layout(self) -> ThemeLayout:
        """A Qtile layout's layout properties mapped to their values

        Example:
        { 'border_width': 5 }
        """
        pass


class Theme:

    def __init__(self, theme: ThemeInstance):
        self.name = theme.name
        self.author = theme.author
        self.repo_url = theme.repo_url

        self.colors = theme.colors()
        self.layout = theme.layout()
        self.named_colors = theme.named_colors()

