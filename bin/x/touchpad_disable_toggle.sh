#!/bin/bash

# disable-while-typing true
# horiz-scroll-enabled true
# left-handed          'mouse'
# motion-acceleration  5.58
# motion-threshold     6
# scroll-method        'edge-scrolling'
# tap-to-click         true
# touchpad-enabled     true

KEY="/org/gnome/settings-daemon/peripherals/touchpad/touchpad-enabled"
VALUE="$(dconf read $KEY)"

if [ "$VALUE" = "true" ]; then
	dconf write $KEY false
else
	dconf write $KEY true
fi

