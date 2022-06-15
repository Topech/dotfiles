from ..wrappers import hc, hc_hook_handler
from . import modes


def start_hook_handler():
    hook_handler = hc_hook_handler("mode_execute")
    while True:
        line = hook_handler.stdout.readline()
        if line:
            line = line.decode('utf-8')
            hook = line.replace("\n", "")
            _, mode_name, key = hook.split("\t")
            print(mode_name, key)
            mode = modes.mode_dict[mode_name]
            print(mode.bindings_dict[key])
            mode.execute(key)


