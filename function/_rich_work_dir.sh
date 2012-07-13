_rich_work_dir()
{
	local dir="$1"
	local branch="$2"

	cd ~/$dir

	[ -n "$branch" ] && _rich_git_checkout $branch
}

