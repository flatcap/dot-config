cd()
{
	local dir=""
	if [ -n "$1" ]; then
		if [ -f "$1" ]; then
			dir="${1%/*}"
		else
			dir="$1"
		fi
	else
		if [ -r "$HOME/.work_dir" ]; then
			dir="$(cat $HOME/.work_dir)"
		else
			dir="$HOME"
		fi
	fi
	command cd "$dir" > /dev/null 2>&1
}

