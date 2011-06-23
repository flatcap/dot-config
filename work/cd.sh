cd()
{
	local d=""
	local w="~/.work_dir"
	if [ -n "$1" ]; then
		if [ -f "$1" ]; then
			d="${1%/*}"
		else
			d="$1"
		fi
	else
		if [ -r "$w" ]; then
			d="$(cat $w)"
		else
			d="~"
		fi
	fi
	command cd "$d" > /dev/null 2>&1
}
