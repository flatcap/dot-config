#!/bin/bash

# push *.gpg to sr:/backup
# exclude bin ssh gnupg

FROM="/mnt/space/backup/"
TO="s:torrent/"

rsync					\
	--archive			\
	--prune-empty-dirs		\
	--exclude "bin"			\
	--exclude "ssh"			\
	--exclude "gnupg"		\
	"$FROM" "$TO"

