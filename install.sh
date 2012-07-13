#!/bin/bash

#ln all the files into their correct places

for dir in alias complete env function; do
	mkdir -p ~/bin/$dir || break

	pushd $dir > /dev/null
	for file in *; do
		ln -s ../../system/$dir/$file ~/bin/$dir/$file
	done
	popd > /dev/null
done

pushd dot > /dev/null
for file in *; do
	ln -s system/dot/$file ~/.$file
done
popd > /dev/null

