#!/bin/bash

SIZE_SMALL="'Source Code Pro for Powerline Medium 12'"
SIZE_LARGE="'Source Code Pro for Powerline Medium 14'"

KEY="/org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/font"

S=$(dconf read "$KEY")

if [ "$S" = "$SIZE_SMALL" ]; then
	dconf write $KEY "$SIZE_LARGE"
else
	dconf write $KEY "$SIZE_SMALL"
fi

