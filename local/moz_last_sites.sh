#!/bin/bash

DB="$HOME/.mozilla/firefox/default/places.sqlite"
EXCLUDE="$HOME/bin/moz_last_sites.txt"
COUNT=${1:-10}

pushd /tmp > /dev/null
cp "$DB" .
BASE=${DB##*/}
echo "select url from moz_places;" | sqlite3 $BASE | grep --invert-match --file=$EXCLUDE | tail -n $COUNT
rm -f "$BASE"
popd > /dev/null

