from . import modes
from .modes import KeybindMode
from ..wrappers import hc



default_mode = KeybindMode(
    "Default",
    persistent=True,
    bindings_dict={
        "Mod4-Shift-r": "reload",
        "Mod4-t":       "spawn ${TERMINAL:-xfce4-terminal}",
        "Mod4-Return":  "spawn dmenu_run",

        "Mod4-n": "cycle",
        "Mod4-b": "cycle -1",

        # "Mod4-m": "fullscreen toggle",

        "Mod4-q": "close_or_remove",

        "Mod4-space": lambda: modes.mode_switch("General"),
        "Mod4-r":     lambda: modes.mode_switch("Resize"),
        "Mod4-s":     lambda: modes.mode_switch("Split"),
        "Mod4-m":     lambda: modes.mode_switch("Move"),
    }
)

general_mode = KeybindMode(
    "General", 
    bindings_dict={
        # "Return":  "spawn dmenu_run",
        "h": "focus left",
        "j": "focus down",
        "k": "focus up",
        "l": "focus right",

        "n": "cycle",
        "b": "cycle -1",

        # "Mod4-m": "fullscreen toggle",

        "q": "close_or_remove",

        "r": lambda: modes.mode_switch("Resize"),
        "s": lambda: modes.mode_switch("Split"),
        "m": lambda: modes.mode_switch("Move"),
        modes.default_mode_escape_key: lambda: modes.mode_switch("Default"),
    }
)


split_mode = KeybindMode(
    "Split",
    bindings_dict={
        "h": "split left   0.5",
        "j": "split bottom 0.5",
        "k": "split top    0.5",
        "l": "split right  0.5",
        "Mod4-r": lambda: modes.mode_switch("Default"),
        modes.default_mode_escape_key: lambda: modes.mode_switch("Default"),
    }
)


#!TODO: binds to move clients to other tags
move_mode = KeybindMode(
    "Move",
    bindings_dict={
        "h": "shift left",
        "j": "shift down",
        "k": "shift up",
        "l": "shift right",
        modes.default_mode_escape_key: lambda: modes.mode_switch("Default"),
    }
)


stepsize = 0.02
resize_mode = KeybindMode(
    "Resize",
    persistent=True,
    non_keys_escape=True,
    bindings_dict={
    "h": f"resize left  +{stepsize}",
    "j": f"resize down  +{stepsize}",
    "k": f"resize up    +{stepsize}",
    "l": f"resize right +{stepsize}",
    modes.default_mode_escape_key: lambda: modes.mode_switch("Default"),
    }
)

# repeat mode
    # whenever numbers are used beforehand?

# media mode


def setup():
    hc("keyunbind --all")
    default_mode.activate()
