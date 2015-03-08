#!/bin/bash

renice --priority 19 --pid $$ > /dev/null
ionice --class 3     --pid $$ > /dev/null

KEY=""
INDEX=0
CUMUL_SIZE=0
MAX_SIZE=100000

function dump_list()
{
	#echo $KEY$INDEX  $CUMUL_SIZE
	CUMUL_SIZE=0
	: $((INDEX++))
}

du -k --max-depth=0 */* | grep -v indices | while IFS=$'\t' read SIZE NAME; do
	INITIAL=${NAME:0:1}
	if [ "$KEY" != "$INITIAL" ]; then
		[ -n "$KEY" ] && dump_list
		KEY=$INITIAL
		INDEX=0
	fi

	if [ $((CUMUL_SIZE+SIZE)) -gt $MAX_SIZE ]; then
		dump_list
	fi

	CUMUL_SIZE=$((CUMUL_SIZE+SIZE))
	echo -en "$NAME\000" >> "$INITIAL$INDEX.txt"
done

dump_list

for i in [a-z][0-9].txt; do
	NAME="${i%.txt}"
	echo -n "$NAME "
	cat "$i" | xargs -0 tar cf "$NAME.tar"
done
echo

find . -maxdepth 1 -name \*.tar -print0 | sort -z | xargs -0 -n1 -P2 xz -9k

encrypt.sh *.tar *.tar.xz

for i in ??.txt; do echo "${i%.txt}"; cat $i | xargs -0 printf "\t%s\n"; done > authors.txt
xz -9vk authors.txt
encrypt authors.txt.xz

find ?/ -type f | sort > books.txt
xz -9vk books.txt
encrypt books.txt.xz

