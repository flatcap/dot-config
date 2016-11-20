#!/bin/bash

RED="'#400000'"
BLACK="'#000000'"

KEY="/org/gnome/desktop/background/primary-color"

C=$(dconf read "$KEY")

if [ "$C" = "$RED" ]; then
	dconf write $KEY "$BLACK"
else
	dconf write $KEY "$RED"
fi

