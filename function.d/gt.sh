function gt ()
{
	(
	cd ~/git/gt > /dev/null
	if [ -z "$1" ]; then
		git branch
	else
		git checkout "$1" 2> /dev/null
	fi
	)
}
