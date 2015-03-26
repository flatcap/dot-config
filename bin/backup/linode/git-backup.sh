#!/bin/bash

PATH="/usr/bin:/usr/sbin"

set -o errexit	# set -e
set -o nounset	# set -u

renice --priority 19 --pid $$ > /dev/null
ionice --class 3     --pid $$ > /dev/null

umask 0077

DATE=$(date "+%Y-%m-%d")
RCPT="Rich Russon (backup) <rich@flatcap.org>"
DIR="/backup/git/$DATE"
GIT_TAR="$DIR/${DATE}.tar"
TAR_OPTS="--warning=no-file-changed"

mkdir --parents $DIR

# Run fsck and garbage collection on the git repos
su - gitolite3 -c "bin/gr tidy >& /dev/null; reset-dates; drop-cache"

cd /var/lib
tar $TAR_OPTS --create --file "$GIT_TAR" gitolite3

cd "$DIR"

xz -6 -T0 "$GIT_TAR"
gpg2 --encrypt --recipient "$RCPT" "$GIT_TAR.xz"
rm -f "$GIT_TAR.xz"

