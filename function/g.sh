function g()
{
	if [ $# = 0 ]; then
		git status --short 2> /dev/null || git branch --verbose --verbose
	else
		git "$@"
	fi
}
