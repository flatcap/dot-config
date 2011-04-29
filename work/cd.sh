cd()
{
	#[ -z "$1" ] && set -- ~
	[ -z "$1" ] && set -- $(cat ~/.work_dir)
	[ -f "$1" ] && set -- "${1%/*}"
	command cd "$1" > /dev/null 2>&1
}

