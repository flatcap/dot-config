#!/bin/bash

FROM="/mnt/space/backup/"
TO="s:torrent/"

rsync					\
	--archive			\
	--prune-empty-dirs		\
	--remove-source-files		\
	--exclude "bin"			\
	--exclude "ssh"			\
	--exclude "gnupg"		\
	"$FROM" "$TO"

find "$FROM" -type d -empty -delete

