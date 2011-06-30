umask 0007

unset MAILCHECK

shopt -s cdspell
shopt -s extglob
shopt -s progcomp

for dir in env alias function complete; do
	[ -d $HOME/bin/$dir.d/ ] || continue;

	for i in $HOME/bin/$dir.d/*; do
		source $i
	done
done

#setterm -blank 0
#setterm -blength 0

[[ $TERM =~ ^(xterm|vt100|linux)$ ]] && bind Space:magic-space

title

[ -f ~/.extra ] && source ~/.extra

