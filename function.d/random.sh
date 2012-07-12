function random ()
{
	export PROMPT_PREFIX=""
	RANDOM_FILE="$(/bin/ls -1 ~/work/dev/random/* | sort --random-sort | head -1)"
	RANDOM_COUNT="$(grep -ci wally $RANDOM_FILE)"
	RANDOM_BASE="$(basename $RANDOM_FILE)"
	title "$RANDOM_BASE : $RANDOM_COUNT"
	reset
	cat $RANDOM_FILE
}

