#!/bin/bash

[ -n "$1" ] || exit 1

for i in "$@"; do
	echo $i
	gpg2 -d "$i" > "${i%.gpg}"
done
