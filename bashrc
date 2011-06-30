umask 0007

unset MAILCHECK

shopt -s cdspell
shopt -s extglob
shopt -s progcomp

unalias -a
for dir in env alias function complete; do
	[ -d $HOME/bin/$dir.d/ ] || continue;

	for i in $HOME/bin/$dir.d/*; do
		source $i
	done
done

[[ $TERM =~ ^(xterm|vt100|linux)$ ]] && bind Space:magic-space

title

source $HOME/.bash_prompt

[ -f ~/.extra ] && source ~/.extra

