# shorten herbstclient to hc
hc() {
    herbstclient "$@"
}


# reset themes for tiling and floating windows
hc attr theme.tiling.reset 1
hc attr theme.floating.reset 1

focusColor='#e47200'  # yellowish
normalColor='#4e0027' # dark red
# Frame Theming
hc set frame_border_active_color $focusColor
hc set frame_border_normal_color '#1b1b1b' 
hc set frame_bg_normal_color     $normalColor
hc set frame_bg_active_color     $focusColor
hc set frame_border_width 1
hc set always_show_frame 1
hc set frame_bg_transparent 1
hc set frame_transparent_width 3
hc set frame_gap 4

## non-frame theming
hc attr theme.active.color $focusColor
hc attr theme.normal.color $normalColor
hc attr theme.urgent.color '#005d5d'
hc attr theme.inner_width 1
hc attr theme.inner_color black
hc attr theme.border_width 3
hc attr theme.floating.border_width 4
hc attr theme.floating.outer_width 1
hc attr theme.floating.outer_color black
hc attr theme.active.inner_color '#3E4A00'
hc attr theme.active.outer_color '#3E4A00'
hc attr theme.background_color '#141414'
hc set window_gap 0
hc set frame_padding 0
hc set smart_window_surroundings 0
hc set smart_frame_surroundings 1
hc set mouse_recenter_gap 0


