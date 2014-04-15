function steal()
{
	local SHELL="bash"
	local USER="$1"
	local PID="$(pgrep -u $USER $SHELL -o)"
	local i

	shift

	for i in $@; do
		echo export $(< /proc/$PID/environ xargs -0 -n1 echo | grep -w "$i")
	done
}

