#!/bin/bash
[[ $- != *i* ]] && exit 0
echo -en "\e[18t" # returns \e[8;??;??t
IFS='[;'
read -d t -s esc params
set -- $params
[ $# = 3 -a "$1" = 8 ] && shift
[ $# != 2 ] && echo error >&2 && exit 1
# echo setting terminal to "$2x$1" >&2
stty sane
stty rows "$1" cols "$2"
