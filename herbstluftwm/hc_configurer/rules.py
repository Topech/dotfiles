from . import hc

def setup():
    hc("unrule -F")

    hc("rule focus=on label=newClientFocus")

    hc("rule windowtype~'_NET_WM_WINDOW_TYPE_(DIALOG|UTILITY|SPLASH)' pseudotile=on label=floatDialogs")
    hc("rule windowtype=_NET_WM_WINDOW_TYPE_DIALOG focus=on label=dialogFocus")
    hc("rule windowtype~'_NET_WM_WINDOW_TYPE_(NOTIFICATION|DOCK|DESKTOP)' manage=off label=desktopLeaveAlone")


##TODO: force apps to a certain tag
#hc rule class=XTerm tag=3 # move all xterms to tag 3


if __name__ == "__main__":
    setup()
