#!/bin/bash

[ $# -gt 0 ] || exit 1

DATE=$(date '+%F')

for ARG in "$@"; do
	ARG=${ARG%/}
	if [[ $ARG =~ / ]]; then
		FILE="${ARG##*/}"
		DIR="${ARG%/*}/"
	else
		FILE="$ARG"
		DIR=""
	fi
	if [[ "$FILE" =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}_ ]]; then
		NEW=${DATE}_${FILE:11}
	else
		NEW="${DATE}_$FILE"
	fi
	if [ ! "$FILE" = "$NEW" ]; then
		mv -vi -- "$DIR$FILE" "$DIR$NEW"
	fi
done

