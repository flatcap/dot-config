function g()
{
	if [ $# = 0 ]; then
		git status --short 2> /dev/null || git branch --verbose --verbose --color | green 'ahead [0-9]\+' | red 'behind [0-9]\+'
	else
		git "$@"
	fi
}
