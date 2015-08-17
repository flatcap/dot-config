#!/bin/bash

[ $# -gt 0 ] || exit 1

DATE=$(date '+%F')

for ARG in "$@"; do
	if [[ $ARG =~ / ]]; then
		FILE="${ARG##*/}"
		DIR="${ARG%/*}/"
	else
		FILE="$ARG"
		DIR=""
	fi
	if [[ "$FILE" =~ ^[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]_ ]]; then
		NEW=${DATE}_${FILE:11}
	else
		NEW="${DATE}_$FILE"
	fi
	mv "$DIR$FILE" "$DIR$NEW"
	echo "$NEW"
done

