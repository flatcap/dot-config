function parse_git_branch ()
{
	#git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/([32m\1[0m)/'
	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
	#git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

