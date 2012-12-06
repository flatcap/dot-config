#!/bin/bash

#ln all the files into their correct places

for dir in alias complete env function; do
	mkdir -p ~/bin/$dir || break

	pushd $dir > /dev/null
	for file in *; do
		ln -sf ../../shell/bash/$dir/$file ~/bin/$dir/$file
	done
	popd > /dev/null
done

pushd bin > /dev/null
for file in *; do
	ln -sf ../shell/bash/bin/$file ~/bin/$file
done
popd > /dev/null

pushd dot > /dev/null
for file in *; do
	ln -sf shell/bash/dot/$file ~/.$file
done
popd > /dev/null

