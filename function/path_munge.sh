function path_munge ()
{
	if ! echo $PATH | egrep -q "(^|:)$1($|:)" ; then
		if [ "$2" = "after" ]; then
			PATH="$PATH:$1"
		else
			PATH="$1:$PATH"
		fi
	fi
}

