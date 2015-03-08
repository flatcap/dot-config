_rich_git_checkout()
{
	local branch="$1"

	if [ -z "$1" ] || [ -n "$2" ]; then
		return
	fi

	for i in gt vte; do
		pushd ~/$i >& /dev/null
		echo -n "$i: "
		git checkout "$branch"
		popd >& /dev/null
	done
}

