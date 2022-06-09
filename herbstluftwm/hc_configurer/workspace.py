import enum

from . import hc
from .globals import tags


def __setup_monitors():
    hc("detect_monitors")


def __setup_tags():
    for tag in tags:
        hc("add", tag)

    hc("set focus_follows_mouse", 'true')
    hc("set default_frame_layout", 'max')

    # reset first tag to max
    hc(f"load {tags[0]} '(clients max:0)'")


def setup():
    __setup_monitors()
    __setup_tags()
