#!/bin/bash

URI="http://www.google.com/custom?hl=en&domains=library.gnome.org&sitesearch=library.gnome.org&q="
SEARCH=$(xsel -o)

[ -z "$SEARCH" ] && exit

firefox "${URI}${SEARCH}"

