#!/bin/bash

LETTER="a"
for i in [a-z][0-9]; do
	if [ ${i:0:1} != $LETTER ]; then
		LETTER=${i:0:1}
		echo
	fi
	pushd $i >& /dev/null
	echo -n "$i "
	find . -type f -print0 | sort -z | tar cf ../$i.tar --null -T -
	popd >& /dev/null
done
echo

