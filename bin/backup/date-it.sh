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

# Compressed function version: 232 characters
# di(){ T=$(date '+%F');for A in "$@";do A=${A%/};if [[ $A =~ / ]];then F="${A##*/}";D="${A%/*}/";else F="$A";D="";fi;[[ "$F" =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}_ ]]&&N=${T}_${F:11}||N="${T}_$F";[ "$F" = "$N" ]||mv -vi "$D$F" "$D$N";done;}

