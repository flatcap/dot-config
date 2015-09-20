#!/bin/bash

for i in $(find . -type d -name \*.git); do
	COUNT=$(find $i -type f | wc -l)
	[ $COUNT -lt 12 ] && continue
	pushd $i
	git tidy
	popd
done

