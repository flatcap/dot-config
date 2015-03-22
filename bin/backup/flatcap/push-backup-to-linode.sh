#!/bin/bash

FROM="/mnt/space/backup/"
TO="s:torrent/"

rsync					\
	--archive			\
	--prune-empty-dirs		\
	--remove-source-files		\
	"$FROM" "$TO"

find "$FROM" -type d -empty -delete

