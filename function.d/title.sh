title()
{
	[ -w /dev/stderr ] || return

	[[ $TERM =~ ^(xterm|vt100)$ ]] || return

	echo -ne "\033]0;${@}\007" > /dev/stderr
}
