#!/bin/bash

[ -n "$1" ] || exit 1

echo "${1#./}"
ebook-meta "$1" | sed 's/^/\t/'
echo

