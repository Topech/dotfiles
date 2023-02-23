import enum

from . import hc



class Colours(enum.Enum):
    focus = '#cc3300' # mellow red
    normal = '#661a00' # greenish brown
    urgent = '#005d5d'

    def __str__(self):
        return f"'{str(self.value)}'"



def __setup_frame_theme():

    hc("set frame_border_active_color", Colours.focus)
    hc("set frame_bg_active_color", Colours.focus)
    hc("set frame_border_normal_color", Colours.normal)
    hc("set frame_bg_normal_color", Colours.normal)

    hc("set frame_border_width", 2)
    hc("set always_show_frame", 1)
    hc("set frame_bg_transparent", 1)
    hc("set frame_transparent_width", 0)
    hc("set frame_gap", 0)



def __setup_theme():
    hc("set_attr theme.inner_width", 0)
    hc("set_attr theme.inner_color", 'black')
    hc("set_attr theme.border_width", 1)

    hc("set_attr theme.active.color", Colours.focus)
    hc("set_attr theme.active.inner_color", Colours.focus)
    hc("set_attr theme.active.outer_color", Colours.focus)

    hc("set_attr theme.normal.color", Colours.normal)
    hc("set_attr theme.normal.inner_color", Colours.normal)
    hc("set_attr theme.normal.outer_color", Colours.normal)

    hc("set_attr theme.urgent.color", Colours.urgent)

    hc("set_attr theme.floating.border_width", 2)
    hc("set_attr theme.floating.outer_width", 1)
    hc("set_attr theme.floating.outer_color", 'black')

    hc("set_attr theme.background_color", 'black')



def setup():
    hc("set_attr theme.tiling.reset", 1)
    hc("set_attr theme.floating.reset", 1)

    __setup_frame_theme()
    __setup_theme()

    hc("set window_gap", 0)
    hc("set window_frame", 0)
    hc("set frame_padding", 0)
    hc("set smart_window_surroundings", 0)
    hc("set smart_frame_surroundings", 0)
    hc("set mouse_recenter_gap", 0)


