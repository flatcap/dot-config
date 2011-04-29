work_dir()
{
	(
	[ -n "$1" ] && cd "$1" > /dev/null
	pwd -P > ~/.work_dir
	)
}
