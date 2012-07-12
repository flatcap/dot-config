md()
{
	[ -z "$1" ] && return
	[ -n "$2" ] && return

	mkdir -p "$1"
	cd "$1"
}

