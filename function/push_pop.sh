function pushd()
{
	builtin pushd "$@" >& /dev/null
	[ $? = 0 ] || echo "pushd failed: $@" > /dev/stderr
}

function popd()
{
	builtin popd "$@" >& /dev/null
	[ $? = 0 ] || echo "popd failed: $@" > /dev/stderr
}

function dirs()
{
	builtin dirs -p -v "$@" #| sed 1d
}

function first()
{
	[ $# = 0 ] && return 0
	for i in "$@"; do
		if [ ! -d "$i" ]; then
			echo "dir doesn't exist: $i"
			continue
		fi
		pushd -n "$i"
	done
	PUSHD_OLD_DIR="$(pwd)"
	pushd -0
	popd -n +1

	alias n='pushd -0; clear; ls'
	alias p='pushd +1; clear; ls'
	# alias n='pushd -0; clear; echo "${PWD##*/}"; echo; git log --pretty=tidy -n 10; echo'
	# alias p='pushd +1; clear; echo "${PWD##*/}"; echo; git log --pretty=tidy -n 10; echo'
	# alias n='pushd -0; clear; echo "${PWD##*/}"; echo; git branch -vv; echo'
	# alias p='pushd +1; clear; echo "${PWD##*/}"; echo; git branch -vv; echo'

	clear
	ls --color=auto -l
	# echo "${PWD##*/}"
	# echo
	# git branch -vv
	# git log --pretty=tidy -n 10
	# echo
}

function last()
{
	builtin dirs -c
	cd "$PUSHD_OLD_DIR"
	unset PUSHD_OLD_DIR

	unalias n >& /dev/null
	unalias p >& /dev/null
}

