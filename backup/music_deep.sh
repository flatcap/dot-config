#!/bin/bash

PATH="/usr/bin:/usr/sbin:/home/flatcap/bin"

set -o errexit	# set -e
set -o nounset	# set -u

renice --priority 19 --pid $$ > /dev/null
ionice --class 3     --pid $$ > /dev/null

umask 0077

BASE="/mnt/space/music"
DATE=$(date "+%Y_%m_%d")
RCPT="Rich Russon (backup) <rich@flatcap.org>"

FILES="${DATE}_music_files.txt"
TAGS="${DATE}_music_tags.txt"

pushd $BASE > /dev/null

[ -f "$FILES" ] && echo "File exists: $FILES" && exit
[ -f "$TAGS"  ] && echo "File exists: $TAGS"  && exit

find . -type f | sort > "$FILES"

find . -type f -name \*.mp3 -print0 | xargs -0 -n1 id3v2 -l          > "$TAGS"
find . -type f -name \*.ogg -print0 | xargs -0 -n1 vorbiscomment -l >> "$TAGS"

xz --best "$FILES"
xz --best "$TAGS"

encrypt.sh "$FILES.xz"
encrypt.sh "$TAGS.xz"

