function g()
{
	local STATUS
	local LINES
	if [ $# = 0 ]; then
		# STATUS="$(git status --short 2> /dev/null | yellow '^[CRMA ][CRMA ] ' | red '^[AUD][AUD] \+[^ ]\+')"
		STATUS="$(git status --short 2> /dev/null | sed 's/^/</')"
		if [ -z "$STATUS" ]; then
			git branch --verbose --verbose --color | green 'ahead [0-9]\+' | red 'behind [0-9]\+' | reverse gone
		else
			LINES=$(echo "$STATUS" | wc -l)
			(
			if [ $LINES -lt 30 ]; then
				echo "$STATUS"
			else
				echo "$STATUS" | column -c $(tput cols) | expand -t8
			fi
			) | red '<[AUD ][AUD ] [^ ]\+' | yellow '<[CRMA][CRMA ] ' | green '<[ AM][CRMA] ' | magenta '<?? ' | sed 's/<//g'
		fi
	else
		git "$@"
	fi
}

