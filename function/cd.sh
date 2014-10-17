
function get_git_top_level()
{
	local d=$(pwd)
	while [ -n "$d" ]; do
		if [ -d "$d"/.git ]; then
			echo "$d"
			break
		fi
		d=${d%/*}
	done
}

function is_git_branch()
{
	local DIR="$1"

	[ -n "$DIR"     ] || return
	[ "$DIR" == "." ] && DIR="master"

	git branch 2> /dev/null | grep -Fqw "$DIR"
}

function get_git_branch()
{
	local git_status="$(git status -unormal 2>&1)"
	if [[ "$git_status" =~ "On branch "([^[:space:]]+) ]]; then
		echo "${BASH_REMATCH[1]}"
	fi
}

function get_project()
{
	local project="$(get_git_top_level)"
	local branch="$(get_git_branch)"
	project="${project##*/}"
	project="${project%-$branch}"
	echo "$project"
}

function cd ()
{
	local LS=""
	if [ -n "$1" ]; then						# Argument to cd
		local LEN=${#1}
		if [ $LEN -gt 2 ]; then
			local HEAD=${1:0:-2}
			local TAIL=${1:${#1}-2:2}
		else
			local HEAD="$1"
			local TAIL=""
		fi
		local GDIR="$1"
		[ "$GDIR" = "." ] && GDIR="master"			# dir=. => master branch

		if [ -f "$1" ]; then					# cd dir/file
			set -- "${1%/*}"
		elif [ -d "$1" -a \( "$1" != "." \) ]; then 		# directory exists (not .)
			set -- "$1"
		elif [ -d "$HEAD" -a "$TAIL" == "ls" ]; then	 	# dirls or dir/ls
			set -- "$HEAD"
			LS="yes"
		elif is_git_branch "$GDIR"; then			# cd {git_branch}
			local project="$(get_project)"
			if [ -d "../$project-$GDIR" ]; then
				set -- "../$project-$GDIR"
			elif [ "$GDIR" = "master" -a -d "../$project" ]; then
				set -- "../$project"
			else
				git checkout -q "$GDIR"
				return
			fi
		elif [ "$1" = "." ]; then				# cd . => pwd -P
			set -- "$(pwd -P)"
		else							# default to cd
			set -- "$1"
		fi
	else								# No argument to cd
		[ -n "$CDDIR" ] && set -- "$CDDIR"
	fi
	builtin cd "$@" > /dev/null 2>&1
	RES=$?
	[ "$LS" = "yes" ] && ls --group-directories-first -lL -T 0 --color=auto -I .\*swp -I lost+found
	return $RES
}

function cddir ()
{
	[ -n "$1" ] && builtin cd "$1" >& /dev/null
	CDDIR=$(pwd -P)
	export IGNOREEOF=999
}

function . ()
{
	if [ -n "$1" ]; then
		source "$@"
	else
		cd .
	fi
}
