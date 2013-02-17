#!/bin/sh

function usage()
{
	echo -e "\nUsage:\n\t${0##*/} scale file(s)\n"
	exit 1
}

[ $# -lt 2 ] && usage

SCALE="$1"
shift
if [[ ! "$SCALE" =~ ^[0-9]+$ ]]; then
	echo "scale isn't numeric: $SCALE"
	exit 1
fi

for FILE in "$@"; do
	if [ ! -f "$FILE" ]; then
		echo "File doesn't exist: $FILE"
		exit 1
	fi

	SUFFIX="${FILE##*.}"
	BASE="${FILE%%.$SUFFIX}"
	OUTPUT="$BASE-${SCALE}m.$SUFFIX"

	if [ -f "$OUTPUT" ]; then
		echo "Output exists: $OUTPUT"
		continue
	fi

	gpsbabel -i $SUFFIX -f "$FILE" -x position,distance=${SCALE}m -o $SUFFIX -F "$OUTPUT"
	if [ ! $? = 0 ]; then
		echo "Conversion failed: $FILE"
		continue
	fi

	tidy -q -xml "$OUTPUT"
	if [ ! $? = 0 ]; then
		echo "Tidy failed: $OUTPUT"
		continue
	fi

	sed -i -e 's/        /\t/g' -e '/<desc>/d' "$OUTPUT"
	if [ ! $? = 0 ]; then
		echo "Sed failed: $OUTPUT"
		continue
	fi

	echo "OK: $OUTPUT"
done
