function g()
{
	if [ $# = 0 ]; then
		git status --short
	else
		git "$@"
	fi
}
