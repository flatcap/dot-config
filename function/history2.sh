history2()
{
	if [ -z "$@" ]; then
		history $(($(tput lines) - 2))
	else
		history | grep -i $@
	fi
}

