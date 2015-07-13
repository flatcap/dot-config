#!/bin/bash

[ $# -gt 0 ] || exit 1

DATE=$(date '+%F')

for FILE in "$@"; do
	if [[ "$FILE" =~ ^[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]_ ]]; then
		NEW=${DATE}_${FILE:11}
	else
		NEW="${DATE}_$FILE"
	fi
	mv "$FILE" "$NEW"
	echo "$NEW"
done

