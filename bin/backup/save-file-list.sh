#!/bin/bash

set -o errexit	# set -e
set -o nounset	# set -u

MEDIA="/run/media"
RESULT="/mnt/space"

[ -d "$MEDIA" ] || exit 0

DIR="$MEDIA/flatcap/TOSHIBA EXT"
if [ -d "$DIR" ]; then
	cd "$DIR"

	FILE="$RESULT/tosh-file"
	find . -type f ! -path './martin/*' | cut -b3- | sort > "$FILE"
	if [ -f "${FILE}.xz" ]; then
		chattr -i "${FILE}.xz"
		rm -f "${FILE}.xz"
	fi

	xz -9 "${FILE}"
	chattr +i "${FILE}.xz"
fi

DIR="$MEDIA/flatcap/tera"
if [ -d "$DIR" ]; then
	cd "$DIR"

	FILE="$RESULT/tera-file"
	find . -type f | cut -b3- | sort > "$FILE"
	if [ -f "${FILE}.xz" ]; then
		chattr -i "${FILE}.xz"
		rm -f "${FILE}.xz"
	fi

	xz -9 "${FILE}"
	chattr +i "${FILE}.xz"

	FILE="$RESULT/tera-dir"
	find . -type d | cut -b3- | sort > "$FILE"
	if [ -f "${FILE}.xz" ]; then
		chattr -i "${FILE}.xz"
		rm -f "${FILE}.xz"
	fi

	xz -9 "${FILE}"
	chattr +i "${FILE}.xz"

	FILE="$RESULT/tera-ls"
	find . -type f -print0 | sort -z | xargs -0 ls -ld > "$FILE"
	if [ -f "${FILE}.xz" ]; then
		chattr -i "${FILE}.xz"
		rm -f "${FILE}.xz"
	fi

	xz -9 "${FILE}"
	chattr +i "${FILE}.xz"
fi

DIR="$MEDIA/flatcap/transcend"
if [ -d "$DIR" ]; then
	cd "$DIR"

	FILE="$RESULT/trans-file"
	find . -type f | cut -b3- | sort > "$FILE"
	if [ -f "${FILE}.xz" ]; then
		chattr -i "${FILE}.xz"
		rm -f "${FILE}.xz"
	fi

	xz -9 "${FILE}"
	chattr +i "${FILE}.xz"

	FILE="$RESULT/trans-dir"
	find . -type d | cut -b3- | sort > "$FILE"
	if [ -f "${FILE}.xz" ]; then
		chattr -i "${FILE}.xz"
		rm -f "${FILE}.xz"
	fi

	xz -9 "${FILE}"
	chattr +i "${FILE}.xz"

	FILE="$RESULT/trans-ls"
	find . -type f -print0 | sort -z | xargs -0 ls -ld > "$FILE"
	if [ -f "${FILE}.xz" ]; then
		chattr -i "${FILE}.xz"
		rm -f "${FILE}.xz"
	fi

	xz -9 "${FILE}"
	chattr +i "${FILE}.xz"
fi

