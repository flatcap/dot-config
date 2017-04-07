#!/bin/bash

SIZE_SMALL="'Source Code Pro for Powerline Medium 12'"
SIZE_LARGE="'Source Code Pro for Powerline Medium 14'"

# Gnome terminal
KEY1="/org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/font"

# Tilix
KEY2="/com/gexperts/Tilix/profiles/2b7c4080-0ddd-46c5-8f23-563fd3ba789d/font"

S=$(dconf read "$KEY1")

if [ "$S" = "$SIZE_SMALL" ]; then
	dconf write $KEY1 "$SIZE_LARGE"
	dconf write $KEY2 "$SIZE_LARGE"
else
	dconf write $KEY1 "$SIZE_SMALL"
	dconf write $KEY2 "$SIZE_SMALL"
fi

