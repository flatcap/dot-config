umask 0007

unset MAILCHECK

shopt -s cdspell
shopt -s extglob
shopt -s progcomp

[ "$TERM" = "xterm" ] && bind Space:magic-space

if [ -d $HOME/bin/function.d/ ]; then
	for i in $HOME/bin/function.d/*; do
		source $i
	done
fi
title

if [ -d $HOME/bin/debug.d/ ]; then
	for i in $HOME/bin/debug.d/*; do
		source $i
	done
fi

if [ -n "$SSH_AUTH_SOCK" ]; then
	echo "export SSH_AUTH_SOCK=$SSH_AUTH_SOCK" > ~/.ssh-agent
else
	source ~/.ssh-agent
fi

if [ -d $HOME/bin/complete.d/ ]; then
	for i in $HOME/bin/complete.d/*; do
		source $i
	done
fi

#setterm -blank 0
#setterm -blength 0

[ -f ~/.extra ] && source ~/.extra

