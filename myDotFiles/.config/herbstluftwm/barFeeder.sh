#!/bin/bash

clock() {
	date +%I:%M:%S\ :\ %D
}

battery() {
    cat /sys/class/power_supply/BAT0/capacity
}

frame() {
	# get number of windows in current frame
	herbstclient layout | grep '[FOCUS]' | grep -o 0x | wc -l
}

while true ; do
    BAR_INPUT="%{c}$(battery)%% : $(clock) %{r}[ $(frame) ]  |"
    echo $BAR_INPUT
    sleep 1
done
