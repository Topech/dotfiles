#!/bin/bash

# Monitor Setup
#
# sets up an arbitrary desktop with the monitor name set as $1


HC_MONITOR_NUM=$1

# set padding of the given monitor
PAD_U=22
PAD_D=22
PAD_L=35
PAD_R=35
hc pad $HC_MONITOR_NUM $PAD_U $PAD_R $PAD_D $PAD_L


#TODO: set bar for each monitor
# the old bar 
oldPanel() {
    panel=~/.config/herbstluftwm/panel.sh
    [ -x "$panel" ] || panel=/etc/xdg/herbstluftwm/panel.sh
    for monitor in $(herbstclient list_monitors | cut -d: -f1) ; do
            # start it on each monitor
            "$panel" $monitor &
    done
}
#oldPanel


