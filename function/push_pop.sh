function pushd()
{
	command pushd "$@" >& /dev/null
	[ $? = 0 ] || echo "pushd failed: $@" > /dev/stderr
}

function popd()
{
	command popd "$@" >& /dev/null
	[ $? = 0 ] || echo "popd failed: $@" > /dev/stderr
}

function dirs()
{
	command dirs | tr ' ' '\n' | sed 1d | nl -w2 -n rn
}

