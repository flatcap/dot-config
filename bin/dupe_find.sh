#!/bin/bash

for i in m{1..3}; do
	if [ -f $i ]; then
		echo "file exists: $i"
		exit 1
	fi
done

find . -type f ! -name m1 -print0 | xargs -r0 md5sum > m1
wc -l m1 | awk '{ printf ("%d files\n", $1); }'

if [ ! -s m1 ]; then
	rm -f m1
	exit 0
fi

sed 's/  .*//' m1 | sort | uniq -d > m2
wc -l m2 | awk '{ printf ("%d dupes\n", $1); }'

if [ ! -s m2 ]; then
	rm -f m1 m2
	exit 0
fi

AWK="${0%.sh}.awk"

for i in $(cat m2); do
	grep -F $i m1
done | LANG=C sort | awk -f $AWK > m3

