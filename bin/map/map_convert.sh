#!/bin/bash

[ $# = 0 ] && exit

for i in "$@"; do
	exec 5<> $i
	read -n 1 var <&5
	echo -n PNG >&5
	exec 5>&-
	mv "$i" "${i%.SMT}.png"
done

