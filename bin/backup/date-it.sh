#!/bin/bash

[ $# -gt 0 ] || exit 1

DATE=$(date '+%F')

for FILE in "$@"; do
	NEW="${DATE}_$FILE"
	mv "$FILE" "$NEW"
	echo "$NEW"
done

