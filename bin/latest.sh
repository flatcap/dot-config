#!/bin/bash

TV="/mnt/tera/tv"
README="readme.html"

[ -d "$TV" ] || exit 1

cd "$TV"

echo "<h1>Latest acquisitions...</h1>"  > $README
echo "<ul>" >> $README

find .  -type f			\
        -mtime -14		\
        ! -name readme.html	\
        ! -path "*indices*"	\
        ! -name ".*"		\
        | sort | sed 's!..\(.*\)!<li><a href="\1">\1</a></li>!' >> $README

echo "</ul>" >> $README
chmod 644 $README

