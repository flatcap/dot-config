#!/bin/bash

DB="places.sqlite"
DB_DIR="$HOME/.mozilla/firefox/default"
BIN_DIR=${0%/*}
EXCLUDE="$BIN_DIR/moz_last_sites.txt"
COUNT=${1:-10}
TMP_DIR="$(mktemp -d)"

#echo "BIN_DIR = $BIN_DIR"
#echo "COUNT   = $COUNT"
#echo "DB_DIR  = $DB_DIR"
#echo "EXCLUDE = $EXCLUDE"
#echo "TMP_DIR = $TMP_DIR"

cp "$DB_DIR/$DB" "$TMP_DIR"
echo "select url from moz_places;" | sqlite3 "$TMP_DIR/$DB" | grep --invert-match --file=$EXCLUDE | tail -n $COUNT
rm -fr "$TMP_DIR"

