function g()
{
	local STATUS
	local LINES
	if [ $# = 0 ]; then
		STATUS="$(git status --short 2> /dev/null)"
		LINES=$(echo "$STATUS" | wc -l)
		if [ $LINES = 0 ]; then
			git branch --verbose --verbose --color | green 'ahead [0-9]\+' | red 'behind [0-9]\+' | reverse gone
		elif [ $LINES -lt 20 ]; then
			echo "$STATUS" | yellow "\<M\>"
		else
			echo "$STATUS" | column -c $(tput cols) | yellow "\<[CRMA]\>  " | red '\<[UD]\+ \+[^ ]\+\>'
		fi
	else
		git "$@"
	fi
}
