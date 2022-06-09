import argparse

from hc_configurer.keybinds import modes
from hc_configurer.wrappers import hc

arg_parser = argparse.ArgumentParser()
arg_parser.add_argument("keychord", metavar="K", type=str, help="keychord to find command for")

args = arg_parser.parse_args()

current_mode = modes.get_current_mode()
current_mode.execute(args.keychord)
