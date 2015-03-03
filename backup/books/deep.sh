#!/bin/bash

PATH="/usr/bin:/usr/sbin:/home/flatcap/bin:."

set -o errexit	# set -e
set -o nounset	# set -u

renice --priority 19 --pid $$ > /dev/null
ionice --class 3     --pid $$ > /dev/null

umask 0077

BASE="/mnt/space/books/documents"
DATE=$(date "+%Y_%m_%d")
RCPT="Rich Russon (backup) <rich@flatcap.org>"

FILES="${DATE}_books_files.txt"
TAGS="${DATE}_books_metadata.txt"

pushd $BASE > /dev/null

[ -f "$FILES" ] && echo "File exists: $FILES" && exit
[ -f "$TAGS"  ] && echo "File exists: $TAGS"  && exit

find . -mindepth 2 -type f | sort | sed 's/^..//' > "$FILES"

find . -type f \( -name \*.mobi -o -name \*.azw \) -print0 | sort --zero-terminated | xargs -0 -n1 books_meta.sh > "$TAGS"

xz --best --keep "$FILES"
xz --best --keep "$TAGS"

encrypt.sh "$FILES.xz"
encrypt.sh "$TAGS.xz"

