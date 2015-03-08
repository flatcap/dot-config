#!/bin/bash

DB="$HOME/.mozilla/firefox/default/places.sqlite"

DIR="${0%/*}"
EXCLUDE="$DIR/moz_last_sites.txt"
COUNT=${1:-10}
QUERY="SELECT url FROM moz_places, moz_historyvisits WHERE (moz_places.id = moz_historyvisits.place_id) ORDER BY visit_date;"

sqlite3 "$DB" "$QUERY" | grep --invert-match --file=$EXCLUDE | tail -n $COUNT

