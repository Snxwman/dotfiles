from dataclasses import dataclass
from typing import final


# https://github.com/catppuccin/catppuccin#-palette
# fmt: off
@final
@dataclass(frozen=True)
class Catppuccin:
    rosewater = "#f5e0dc"
    flamingo  = "#f2cdcd"
    pink      = "#f5c2e7"
    mauve     = "#cba6f7"
    red       = "#f38ba8"
    maroon    = "#eba0ac"
    peach     = "#fab387"
    yellow    = "#f9e2af"
    green     = "#a6e3a1"
    teal      = "#94e2d5"
    sky       = "#89dceb"
    sapphire  = "#74c7ec"
    blue      = "#89b4fa"
    lavender  = "#b4befe"

    text      = "#cdd6f4"
    subtext1  = "#bac2de"
    subtext0  = "#a6adc8"
    overlay2  = "#9399b2"
    overlay1  = "#7f849c"
    overlay0  = "#6c7086"
    surface2  = "#585b70"
    surface1  = "#45475a"
    surface0  = "#313244"
    base      = "#1e1e2e"
    mantle    = "#181825"
    crust     = "#11111b"

# https://www.stephango.com/flexoki
# fmt: off
@final
@dataclass(frozen=True)
class Flexoki:
    red             = '#AF3029'
    red_l           = '#D14D41'
    orange          = '#BC5215'
    orange_l        = '#DA702C'
    yellow          = '#AD8301'
    yellow_l        = '#D0A215'
    green           = '#66800B'
    green_l         = '#879A39'
    cyan            = '#24837B'
    cyan_l          = '#3AA99F'
    blue            = '#205EA6'
    blue_l          = '#4385BE'
    purple          = '#5E409D'
    purple_l        = '#8B7EC8'
    magenta         = '#A02F6F'
    magenta_l       = '#CE5D97'
    paper           = '#FFFCF0'
    white           = '#FFFCF0'
    black           = '#100F0F'

    base_950        = '#1C1B1A'
    base_900        = '#282726'
    base_850        = '#343331'
    base_800        = '#403E3C'
    base_700        = '#575653'
    base_600        = '#6F6E69'
    base_500        = '#878580'
    base_400        = '#9F9D96'
    base_300        = '#B7B5AC'
    base_200        = '#CECDC3'
    base_150        = '#DAD8CE'
    base_100        = '#E6E4D9'
    base_050        = '#F2F0E5'

    red_950         = '#261312'
    red_900         = '#3E1715'
    red_850         = '#551B18'
    red_800         = '#6C201C'
    red_700         = '#942822'
    red_600         = '#AF3029'
    red_500         = '#C03E35'
    red_400         = '#D14D41'
    red_300         = '#E8705F'
    red_200         = '#F89A8A'
    red_150         = '#FDB2A2'
    red_100         = '#FFCABB'
    red_050         = '#FFE1D5'

    orange_950      = '#27180E'
    orange_900      = '#40200D'
    orange_850      = '#59290D'
    orange_800      = '#71320D'
    orange_700      = '#9D4310'
    orange_600      = '#BC5215'
    orange_500      = '#CB6120'
    orange_400      = '#DA702C'
    orange_300      = '#EC8B49'
    orange_200      = '#F9AE77'
    orange_150      = '#FCC192'
    orange_100      = '#FED3AF'
    orange_050      = '#FFE7CE'

    yellow_950      = '#241E08'
    yellow_900      = '#3A2D04'
    yellow_850      = '#503D02'
    yellow_800      = '#664D01'
    yellow_700      = '#8E6B01'
    yellow_600      = '#AD8301'
    yellow_500      = '#BE9207'
    yellow_400      = '#D0A215'
    yellow_300      = '#DFB431'
    yellow_200      = '#ECCB60'
    yellow_150      = '#F1D67E'
    yellow_100      = '#F6E2A0'
    yellow_050      = '#FAEEC6'

    green_950       = '#1A1E0C'
    green_900       = '#252D09'
    green_850       = '#313D07'
    green_800       = '#3D4C07'
    green_700       = '#536907'
    green_600       = '#66800B'
    green_500       = '#768D21'
    green_400       = '#879A39'
    green_300       = '#A0AF54'
    green_200       = '#BEC97E'
    green_150       = '#CDD597'
    green_100       = '#DDE2B2'
    green_050       = '#EDEECF'

    cyan_950        = '#101F1D'
    cyan_900        = '#122F2C'
    cyan_850        = '#143F3C'
    cyan_800        = '#164F4A'
    cyan_700        = '#1C6C66'
    cyan_600        = '#24837B'
    cyan_500        = '#2F968D'
    cyan_400        = '#3AA99F'
    cyan_300        = '#5ABDAC'
    cyan_200        = '#87D3C3'
    cyan_150        = '#A2DECE'
    cyan_100        = '#BFE8D9'
    cyan_050        = '#DDF1E4'

    blue_950        = '#101A24'
    blue_900        = '#12253B'
    blue_850        = '#133051'
    blue_800        = '#163B66'
    blue_700        = '#1A4F8C'
    blue_600        = '#205EA6'
    blue_500        = '#3171B2'
    blue_400        = '#4385BE'
    blue_300        = '#66A0C8'
    blue_200        = '#92BFDB'
    blue_150        = '#ABCFE2'
    blue_100        = '#C6DDE8'
    blue_050        = '#E1ECEB'

    purple_950      = '#1A1623'
    purple_900      = '#261C39'
    purple_850      = '#31234E'
    purple_800      = '#3C2A62'
    purple_700      = '#4F3685'
    purple_600      = '#5E409D'
    purple_500      = '#735EB5'
    purple_400      = '#8B7EC8'
    purple_300      = '#A699D0'
    purple_200      = '#C4B9E0'
    purple_150      = '#D3CAE6'
    purple_100      = '#E2D9E9'
    purple_050      = '#F0EAEC'

    magenta_950     = '#24131D'
    magenta_900     = '#39172B'
    magenta_850     = '#4F1B39'
    magenta_800     = '#641F46'
    magenta_700     = '#87285E'
    magenta_600     = '#A02F6F'
    magenta_500     = '#B74583'
    magenta_400     = '#CE5D97'
    magenta_300     = '#E47DA8'
    magenta_200     = '#F4A4C2'
    magenta_150     = '#F9B9CF'
    magenta_100     = '#FCCFDA'
    magenta_050     = '#FEE4E5'

    base = base_950 
    text = base_200

palette = Catppuccin()
flexoki = Flexoki()
