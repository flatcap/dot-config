cd()
{
	local w=~/.cd_dir
	if [ -n "$1" ]; then
		[ -f "$1" ] && set -- "${1%/*}"
	else
		[ -r $w ] && set -- "$(cat $w)"
	fi
	command cd "$1" > /dev/null 2>&1
}
