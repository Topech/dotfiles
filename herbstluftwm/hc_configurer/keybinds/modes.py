import os

from ..wrappers import hc




all_keys = [
"1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "minus", "equal", 
"q", "w", "e", "r", "t", "y", "u", "i", "o", "p", "backslash",
"a", "s", "d", "f", "g", "h", "j", "k", "l", "quoteright", "semicolon", 
"z", "x", "c", "v", "b", "n", "m", "comma", "period", "slash",
# "Left", "Up", "Down", "Right",
]


# store all KeybindModes in this dict
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
    


default_mode_escape_key = "Mod4-Escape"

class KeybindMode():

    def __init__(self, name, persistent=False, bindings_dict={}, non_keys_escape=False):
        self.name = name
        self.persistent = persistent
        self.non_keys_escape = non_keys_escape
        self.set_bindings(bindings_dict)
        mode_dict[name] = self

    def _normal_typing_escape_binds(self):
        escape_binds = {key: lambda: mode_switch("Default") for key in all_keys}
        shifted_escape_binds = {f"Shift-{key}": lambda: mode_switch("Default") for key in all_keys}
        escape_binds.update(shifted_escape_binds)
        return escape_binds

    def set_bindings(self, bindings_dict):
        if self.non_keys_escape:
            self.bindings_dict = self._normal_typing_escape_binds()
            self.bindings_dict.update(bindings_dict)
        else:
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
