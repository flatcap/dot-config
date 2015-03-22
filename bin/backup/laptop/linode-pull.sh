#!/bin/bash

SOURCE="sr:/backup/"
DEST="/mnt/space/backup/linode/"

OPTS="$OPTS --archive"
OPTS="$OPTS --partial"
OPTS="$OPTS --bwlimit 2048"

mkdir -p $DEST

rsync $OPTS $SOURCE $DEST

