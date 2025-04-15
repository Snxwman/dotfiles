from libqtile import hook

from core.screens import screens

bars = [screen.top or screen.bottom for screen in screens]
margins = [sum(bar.margin) if bar else -1 for bar in bars]


# @hook.subscribe.startup
# def startup():
#     for bar, margin in zip(bars, margins):
#         if not margin:
#             bar.window.window.set_property(
#                 name="WM_NAME",
#                 value="QTILE_BAR",
#                 type="STRING",
#                 format=8,
#             )


@hook.subscribe.client_managed
async def new_client(client):
    # center = lambda w, h: ((5120 - w)//2, (1440 - h)//2)

    match client.name:
        case "Calculator":
            width, height = 360, 616
            client.set_size_floating(width, height)
            # client.set_position_floating(*center(width, height))
        # case "Mullvad VPN":
            # width, height = 320, 568
            # client.set_position_floating(*center(width, height))


