#!/bin/bash

#[ -n "$1" ] && exit 0

MAGNET=$(echo "$1" | sed 's/&.*//')

/usr/bin/deluge $MAGNET

