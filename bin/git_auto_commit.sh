#!/bin/bash

function work()
{
	git add --all .
	COUNT="$(git status --short | wc -l)"
	[ "$COUNT" = 0 ] && return
	git commit --message "auto-commit $COUNT files"
	REMOTE="$(git remote)"
	[ -n "$REMOTE" ] && git push
}


DIR="$1"

[ -n "$DIR" ] || DIR="."
[ -d "$DIR" ] || exit 1
cd   "$DIR"   || exit 1

EVENT="0"
TIMEOUT="5"
STOP_FILE="STOP"

EVENTS=(CREATE MODIFY MOVED_TO ATTRIB DELETE)

EVENT_ARGS=$(printf -- " --event %s" ${EVENTS[*]})

work	# initial commit

while :; do
	inotifywait				\
		--quiet				\
		--quiet				\
		--recursive			\
		--timeout "$TIMEOUT"		\
		$EVENT_ARGS			\
		--exclude .git/			\
		"$DIR"

	# Note that an event occurred
	if [ $? = 0 ]; then
		if [ -f "$STOP_FILE" ]; then
			rm -f "$STOP_FILE"
			#echo STOP
			break
		fi
		EVENT=1
		#echo EVENT
		continue
	fi

	# A timeout occurred, but there were no events
	if [ $EVENT = 0 ]; then
		# $STOP_FILE exists -- finish
		#echo TIMEOUT - NOTHING
		continue
	fi

	# $TIMEOUT seconds after an event
	EVENT=0
	work
done

