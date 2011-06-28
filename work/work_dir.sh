work_dir()
{
	[ -n "$1" ] && cd "$1"
	CDDIR=$(pwd -P)
}
