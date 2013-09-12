title()
{
	[ -w /dev/stderr ] || return

	[[ $TERM =~ ^(xterm|xterm-256color|vt100)$ ]] || return

	echo -ne "\e]0;${@}\a" > /dev/stderr
}

