_comp_makefile()
{
	local cur
	local file="Makefile"

	cur=${COMP_WORDS[COMP_CWORD]}

	if [ -f $file ]; then
		LIST="$(grep -io "^[-a-z_ ]\+:" $file | cut -d: -f1)"
		COMPREPLY=( $(compgen -W "$LIST" $cur) )
	else
		COMPREPLY="()"
	fi
}

complete -F _comp_makefile make
complete -F _comp_makefile m
