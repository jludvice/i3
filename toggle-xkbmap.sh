#!/bin/bash
#
# Quickly switch between a given keyboard layout and the US Qwerty one

CURRENT="$(setxkbmap -query | grep layout | perl -pe 's/^layout: +([^ ]+)$/$1/')"

if [ "$CURRENT" = "us" ] ; then
    setxkbmap -layout sk
else
    setxkbmap -layout us
fi
