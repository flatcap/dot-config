#!/bin/bash

[ $# = 0 ] && exit 0

for KML in "$@"; do
	if [ ! -f "$KML" ]; then
		echo "File doesn't exist: $KML"
		exit 1
	fi

	if [[ ! "$KML" =~ .*\.kml ]]; then
		echo Not a KML file: $KML
		continue
	fi

	GPX="${KML%%.kml}.gpx"
	if [ -f "$GPX" ]; then
		echo "Output exists: $GPX"
		continue
	fi

	gpsbabel -i kml -f "$KML" -o gpx -F "$GPX"
	if [ ! $? = 0 ]; then
		echo "Conversion failed: $KML"
		continue
	fi

	tidy -q -xml "$GPX"
	if [ ! $? = 0 ]; then
		echo "Tidy failed: $GPX"
		continue
	fi

	sed -i 's/        /\t/g' "$GPX"
	if [ ! $? = 0 ]; then
		echo "Sed failed: $GPX"
		continue
	fi

	echo "OK: $GPX"
done

