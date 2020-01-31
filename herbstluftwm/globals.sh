## Global Vars

bgim='/home/no5a/Pictures/backgrounds/tripleCircle/bigImage.png'
hcHome="${HOME}/.config/herbstluftwm"
hcModules="${hcHome}/modules"

# set tag names and their corresponding keys
tagNames=( {1..9} 0 )
tagKeys=( {1..9} 0 )

# set mod button to windows key
Mod=Mod4

# shorten herbstclient to hc
hc() {
    herbstclient "$@"
}
