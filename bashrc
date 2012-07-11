[ -f ~/.bash_config ] && source ~/.bash_config

umask 0027

unset MAILCHECK

shopt -s cdspell
shopt -s extglob
shopt -s progcomp

unalias -a
for dir in env function complete alias; do
	[ -d $HOME/bin/$dir.d/ ] || continue;

	for i in $HOME/bin/$dir.d/*; do
		source $i
	done
done

[[ $TERM =~ ^(xterm|vt100|linux)$ ]] && bind Space:magic-space

[ -f ~/.bash_prompt ] && source ~/.bash_prompt
[ -f ~/.extra       ] && source ~/.extra

