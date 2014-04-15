#!/bin/bash

# turn caps lock into an escape key
xmodmap -e "remove lock = Caps_Lock"
xmodmap -e "keycode 66 = Escape"

# make altgr act as a normal alt key
xmodmap -e "keycode 108 = Alt_R"
xmodmap -e "add mod1 = Alt_R"

