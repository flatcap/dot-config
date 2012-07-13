function job_done ()
{
(
	{
		for i in $(seq 10); do
			numlockx off
			numlockx on
			usleep 100000
		done
		echo -ne "\033]0;${PWD/#$HOME/~}\007"
	} &
)
}

