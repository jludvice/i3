#!/usr/bin/env bash

function change {
	CMD=$(amixer get Master | grep -E '^\s+Mono')
	if [[ $VOL_INFO == *off* ]]; then
		#amixer sset Master toggle
		amixer -D pulse sset Master Playback Switch toggle
	fi
	amixer set Master $1
}

[[ "$1" == "up" ]] && change 15%+
[[ "$1" == "down" ]] && change 15%-
[[ "$1" == "mute" ]] && amixer -D pulse sset Master Playback Switch toggle

VOL_INFO=$(amixer get Master | grep -E '^\s+Mono')

if [[ $VOL_INFO == *off* ]]; then
	volnoti-show -m
else
	VOL=$(echo $VOL_INFO | grep -o -P '\d+%')
	volnoti-show $VOL
	canberra-gtk-play --file=/usr/share/sounds/ubuntu/stereo/message.ogg
fi

exit 0
