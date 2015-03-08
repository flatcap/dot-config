function _history_sync()
{
	builtin history -a
	HISTFILESIZE=$HISTSIZE
	builtin history -c
	uniq $HISTFILE | sponge $HISTFILE
	builtin history -r
}

function history2()
{
	_history_sync
	if [ -z "$@" ]; then
		history $(($(tput lines) - 2))
	else
		history | grep --color -i $@
	fi
}

