#!/bin/bash

KEY="/org/gnome/terminal/legacy/shortcuts-enabled"
VALUE="$(dconf read $KEY)"

if [ "$VALUE" = "true" ]; then
	dconf write $KEY false
	echo disabled
else
	dconf write $KEY true
	echo enabled
fi

