umask 0007

unset MAILCHECK

shopt -s cdspell
shopt -s extglob
shopt -s progcomp

[[ $TERM =~ ^(xterm|vt100|linux)$ ]] && bind Space:magic-space

if [ -d $HOME/bin/function.d/ ]; then
	for i in $HOME/bin/function.d/*; do
		source $i
	done
fi
title

if [ -d $HOME/bin/complete.d/ ]; then
	for i in $HOME/bin/complete.d/*; do
		source $i
	done
fi

#setterm -blank 0
#setterm -blength 0

[ -f ~/.extra ] && source ~/.extra

