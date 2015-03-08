function l ()
{
	/bin/ls --group-directories-first -gG -lL -T 0 --color=auto -I .\*swp -I lost+found --time-style="+" -gG --color=yes "$@" | sed '/^.[-r][-w][-xs]/s/^\(....\)\(.......\)\(.*\)/\1\3/g'
}

