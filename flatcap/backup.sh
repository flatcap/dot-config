#!/bin/bash

FROM="/mnt/space/backup/"
TO="s:torrent/"

rsync					\
	--archive			\
	--prune-empty-dirs		\
	--remove-source-files		\
	--exclude "bin"			\
	--exclude "*_ssh.tar.xz"	\
	--exclude "*_gnupg.tar.xz"	\
	"$FROM" "$TO"

find "$FROM" -type d -empty -delete

