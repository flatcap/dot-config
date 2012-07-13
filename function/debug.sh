function debug ()
{
	pushd /usr/src/debug >& /dev/null
	if [ -n "$1" ]; then
		vi -t "$1"
		popd >& /dev/null
	fi
}

