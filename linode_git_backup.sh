#!/bin/bash

renice -n 19 $$ > /dev/null

umask 0077
cd /home/flatcap

DATE=$(date "+%Y_%m_%d")
DIR="/backup/$DATE"

mkdir -p $DIR

tar cf $DIR/git.tar git www

xz -6 $DIR/git.tar

chmod --silent 400 $DIR/*

chattr +i $DIR/*

