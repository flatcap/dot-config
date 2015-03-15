title()
{
	local prompt=""
	local title=""
	local prefix="$PROMPT_PREFIX"

	[ -n "$prefix" ] && prefix="[$prefix]"

	case $1 in
	"")
		title="${PWD/#$HOME/~}"
		prompt='echo -ne "\033]2;'${prefix}' ${PWD/#$HOME/~}$(parse_git_branch)\007"'
		;;
	"-")
		;;
	"done")
		title="done"
		;;
	*)
		title="$*"
		;;
	esac
	title="$prefix $title"

	echo -ne "\033]2;${title}\007" > /dev/stderr
	# PROMPT_COMMAND="echo -n ; $prompt"
}

export -f title

