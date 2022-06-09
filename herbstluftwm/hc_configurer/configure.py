from .wrappers import hc
from . import rules, visuals, workspace, keybinds


def configure():
    # reload all currently running herbstclients
    hc("emit_hook reload")

    # set how trees are displayed
    hc("set tree_style '╾│ ├└╼─┐'")


    # Stop updates to screen until end of script
    hc("lock")

    rules.setup()
    visuals.setup()
    workspace.setup()
    keybinds.setup()

    hc("unlock")
