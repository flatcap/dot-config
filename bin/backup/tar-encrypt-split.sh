#!/bin/bash

set -o errexit	# set -e
set -o nounset	# set -u

renice --priority 19 --pid $$ > /dev/null
ionice --class 3     --pid $$ > /dev/null

RCPT="Rich Russon (backup) <rich@flatcap.org>"
DIR="${1%/}"
SUFFIX=".tar.gpg"
NUM_LENGTH=2
CHUNK_SIZE="1G"

[ -d "$DIR" ] || exit 1

tar --sort=name -cvf - "$DIR" \
	| gpg --encrypt --hidden-recipient "$RCPT" --compress-algo none -o - \
	| split --bytes "$CHUNK_SIZE" --additional-suffix="$SUFFIX" --numeric-suffixes=1 --suffix-length="$NUM_LENGTH" - "${DIR}-"

