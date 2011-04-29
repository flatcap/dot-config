job_done()
{
(
	{
		local i
		for ((i = 0; i < 10; i++)); do
			numlockx off
			numlockx on
			usleep 100000
		done
		echo -ne "\033]0;${PWD/#$HOME/~}\007"
	} &
)
}

