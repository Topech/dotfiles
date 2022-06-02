!/bin/bash



## WM Control Settings
hc keybind $Mod-Shift-r reload
#hc keybind $Mod-Shift-Escape quit

## Program launching
hc keybind $Mod-t spawn ${TERMINAL:-xfce4-terminal}
hc keybind $Mod-space spawn dmenu_run


hc new_attr bool keys.my_user_mode_active false
hc set_attr keys.my_user_mode_active false


hc keybind $Mod-p keybind 2 chain --- \
    spawn dmenu_run --- \
    keyunbind 2


"
hc keybind $Mod-Shift-p chain -c- \
        set_attr keys.my_user_mode_active toggle \
        -c- \
        and -a- compare keys.my_user_mode_active = true -a- \
            keybind 2 spawn dmenu_run \
        -c- \
        and -a- compare keys.my_user_mode_active = false -a- \
            keyunbind 2 
"


hc_keybind_hydra () {
    local START_KEY="$1"
    local NEXT_KEY="$2"
    local HC_COMMAND="$3"
    local HC_ATTR="$4"

    hc keybind "$START_KEY" chain -c- \
            set_attr "$HC_ATTR" toggle \
            -c- \
            and -a- compare "$HC_ATTR" = true -a- \
                keybind "$NEXT_KEY" $HC_COMMAND \
            -c- \
            and -a- compare "$HC_ATTR" = false -a- \
                keyunbind "$NEXT_KEY" 
}


hc_keybind_hydra "$Mod-Shift-p" 2 "spawn dmenu_run" "keys.my_user_mode_active"


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
hc new_attr bool keys.my_resize_mode_active? false
hc set_attr keys.my_resize_mode_active? false

hc keybind $Mod-r chain \
    --c-- set_attr "keys.my_resize_mode_active?" toggle \
    --c-- and \
        --a-- compare "keys.my_resize_mode_active?" = true \
        --a-- keybind h resize left  +$rstep \
        --a-- keybind j resize down  +$rstep \
        --a-- keybind k resize up    +$rstep \
        --a-- keybind l resize right +$rstep \
    --c-- and \
        --a-- compare "keys.my_resize_mode_active?" = false \
        --a-- chain . keyunbind h . keyunbind j . keyunbind k . keyunbind l

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
hc keybind $Mod-q close_or_remove
hc keybind XF86Launch1 spawn xkill

# Move Client Between Frames
hc keybind $Mod-Shift-h shift left
hc keybind $Mod-Shift-j shift down
hc keybind $Mod-Shift-k shift up
hc keybind $Mod-Shift-l shift right

## Mouse Control
hc mouseunbind --all
hc mousebind $Mod-B1 move
hc mousebind $Mod-B2 resize

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
