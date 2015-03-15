#!/bin/bash

# link the files into their correct places

BASE=${0%/*}
cd "$BASE/dot"

DIR=$(pwd)

for file in *; do
	ln -sf $DIR/$file ~/.$file
done

