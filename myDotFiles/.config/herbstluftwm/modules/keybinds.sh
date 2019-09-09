#!/bin/bash

# shorten herbstclient to hc
hc() {
    herbstclient "$@"
}


# Win key as mod
Mod="$1"

## WM Control Settings
hc keybind $Mod-Shift-r reload
hc keybind $Mod-Shift-Escape quit

## Program launching
hc keybind $Mod-t spawn ${TERMINAL:-xfce4-terminal}
hc keybind $Mod-space spawn dmenu_run_hlwm


## Frame Control
# Make Frames
hc keybind $Mod-Control-h split left    0.5
hc keybind $Mod-Control-j split bottom  0.5
hc keybind $Mod-Control-k split top     0.5
hc keybind $Mod-Control-l split right   0.5

# Remove Frames
hc keybind $Mod-Shift-q remove

# Resize frames
rstep=0.02

hc keybind $Mod-Left  resize left  +$rstep
hc keybind $Mod-Down  resize down  +$rstep
hc keybind $Mod-Up    resize up    +$rstep
hc keybind $Mod-Right resize right +$rstep


## Client Control
# client focussing
hc keybind $Mod-h focus left
hc keybind $Mod-j focus down
hc keybind $Mod-k focus up
hc keybind $Mod-l focus right

# client cycling in frame
hc keybind $Mod-n cycle
hc keybind $Mod-b cycle -1

# Fullscreen
hc keybind $Mod-m fullscreen toggle

# close client
hc keybind $Mod-q close

# Move Client Between Frames
hc keybind $Mod-Shift-h shift left
hc keybind $Mod-Shift-j shift down
hc keybind $Mod-Shift-k shift up
hc keybind $Mod-Shift-l shift right

## Mouse Control
hc mouseunbind --all
hc mousebind $Mod-Button1 move
hc mousebind $Mod-Button2 resize

## Layouts
hc keybind $Mod-f floating toggle


# Hardware Keys
## Audio
hc keybind XF86AudioRaiseVolume spawn pactl set-sink-volume 0 +5%
hc keybind XF86AudioLowerVolume spawn pactl set-sink-volume 0 -5%
hc keybind XF86AudioMute spawn pactl set-sink-mute 0 toggle

## Media
hc keybind XF86AudioPlay spawn playerctl play-pause
hc keybind XF86AudioNext spawn playerctl next
hc keybind XF86AudioPrev spawn playerctl previous
