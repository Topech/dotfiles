import os

from ..wrappers import hc, hc_hook_handler
from .. import globals


default_mode_escape_key = "Mod4-Escape"

mode_dict = {}


def get_current_mode():
    mode_name = os.getenv("HC_KEYBIND_MODE")
    return mode_dict[mode_name]


def set_current_mode(new_mode):
    os.environ["HC_KEYBIND_MODE"] = new_mode.name


def mode_switch(new_mode_name):
    current_mode = get_current_mode()
    current_mode.deactivate()
    new_mode = mode_dict[new_mode_name]
    new_mode.activate()
    


class KeybindMode():
    
    def __init__(self, name, persistent=False, bindings_dict={}):
        self.name = name
        self.persistent = persistent
        self.set_bindings(bindings_dict)
        mode_dict[name] = self

    def set_bindings(self, bindings_dict):
        self.bindings_dict = bindings_dict
        self._activate_command_chain = ""
        self._deactivate_command_chain = ""
        chain_delim = "--c--"
        for key in self.bindings_dict.keys():
            activate_command = f"{chain_delim} keybind {key} emit_hook mode_execute {self.name} {key}"
            self._activate_command_chain += " " + activate_command
            deactivate_command = f"{chain_delim} keyunbind {key}"
            self._deactivate_command_chain += " " + deactivate_command

    def activate(self):
        set_current_mode(self)
        hc("chain", self._activate_command_chain)

    def execute(self, key):
        command = self.bindings_dict[key]
        if type(command) == str:
            hc(command)
        else:
            command()
        if self.persistent is False:
            mode_switch("Default")

    def deactivate(self):
        hc("chain", self._deactivate_command_chain)




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

        "Mod4-space": lambda: mode_switch("General"),
        "Mod4-r":     lambda: mode_switch("Resize"),
        "Mod4-s":     lambda: mode_switch("Split"),
        "Mod4-m":     lambda: mode_switch("Move"),
    }
)

general_mode = KeybindMode(
    "General", 
    bindings_dict={
        "Return":  "spawn dmenu_run",
        "h": "focus left",
        "j": "focus down",
        "k": "focus up",
        "l": "focus right",

        "n": "cycle",
        "b": "cycle -1",

        # "Mod4-m": "fullscreen toggle",

        "q": "close_or_remove",

        "r": lambda: mode_switch("Resize"),
        "s": lambda: mode_switch("Split"),
        "m": lambda: mode_switch("Move"),
        default_mode_escape_key: lambda: mode_switch("Default"),
    }
)


split_mode = KeybindMode(
    "Split",
    bindings_dict={
        "h": "split left   0.5",
        "j": "split bottom 0.5",
        "k": "split top    0.5",
        "l": "split right  0.5",
        default_mode_escape_key: lambda: mode_switch("Default"),
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
        default_mode_escape_key: lambda: mode_switch("Default"),
    }
)


stepsize = 0.02
resize_mode = KeybindMode(
    "Resize",
    persistent=True,
    bindings_dict={
    "h": f"resize left  +{stepsize}",
    "j": f"resize down  +{stepsize}",
    "k": f"resize up    +{stepsize}",
    "l": f"resize right +{stepsize}",
    default_mode_escape_key: lambda: mode_switch("Default"),
    }
)

# repeat mode
    # whenever numbers are used beforehand?

# media mode


def setup():
    default_mode.activate()


def start_hook_handler():
    hook_handler = hc_hook_handler("mode_execute")
    while True:
        line = hook_handler.stdout.readline()
    # for line in hook_handler.stdout:
        if line:
            line = line.decode('utf-8')
            hook = line.replace("\n", "")
            _, mode_name, key = hook.split("\t")
            print(mode_name, key)
            mode = mode_dict[mode_name]
            mode.execute(key)
