#!/bin/bash

[ $# = 0 ] && exit 0

for GPX in "$@"; do
	if [ ! -f "$GPX" ]; then
		echo "File doesn't exist: $GPX"
		exit 1
	fi

	if [[ ! "$GPX" =~ .*\.gpx ]]; then
		echo Not a GPX file: $GPX
		continue
	fi

	KML="${GPX%%.gpx}.kml"
	if [ -f "$KML" ]; then
		echo "Output exists: $KML"
		continue
	fi

	gpsbabel -i gpx -f "$GPX" -o kml -F "$KML"
	if [ ! $? = 0 ]; then
		echo "Conversion failed: $GPX"
		continue
	fi

	tidy -q -xml "$KML"
	if [ ! $? = 0 ]; then
		echo "Tidy failed: $KML"
		continue
	fi

	sed -i 's/        /\t/g' "$KML"
	if [ ! $? = 0 ]; then
		echo "Sed failed: $KML"
		continue
	fi

	echo "OK: $KML"
done

