#!/bin/bash

BIN_DIR=${0%/*}
MAC_FILE="$BIN_DIR/macs.txt"
MAC_REGEX="[[:xdigit:]][[:xdigit:]]:[[:xdigit:]][[:xdigit:]]:[[:xdigit:]][[:xdigit:]]:[[:xdigit:]][[:xdigit:]]:[[:xdigit:]][[:xdigit:]]:[[:xdigit:]][[:xdigit:]]"
ICON="/usr/share/icons/gnome/48x48/apps/system-users.png"

[ -n "$1" ] && unset DISPLAY

USERS=$(sudo arp-scan -I p4p1 -l -m $MAC_FILE | sed -e '/ignore/d' -ne '/..:..:../p'| while read ip mac name; do echo "    $name ($ip)"; done)

[ -z "$USERS" ] && USERS="    Nobody else"

if [ -n "$DISPLAY" ]; then
	notify-send -i $ICON "Online:" "$USERS"
fi

echo "Online:"
echo "$USERS" | sed -e 's/<\/*[^>]\+>//g' -e 's//\n/g' | column -t | sed 's/^/    /'

