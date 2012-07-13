#!/bin/bash

TV="/mnt/tera/tv"
README="readme.html"
TMP1="$(mktemp)"
TMP2="$(mktemp)"

[ -d "$TV" ] || exit 1

cd "$TV"

echo "<h1>Latest acquisitions...</h1>"  > $README
echo "<ul>" >> $README

find .  -type f			\
        -mtime -14		\
        ! -name readme.html	\
        ! -name favicon.png	\
        ! -path "*indices*"	\
        ! -name ".*"		\
	| sed 's/^..//' | sort > $TMP1
sed -e 's/&/\&amp;/g' -e 's/ /%20/g' -e 's/"/\&quot;/g' -e "s/'/\&apos;/g" $TMP1 > $TMP2
paste $TMP1 $TMP2 | sed 's!\(.*\)\t\(.*\)!<li><a href="\2">\1</a></li>!' >> $README

echo "</ul>" >> $README
chmod 644 $README

rm -f $TMP1 $TMP2

