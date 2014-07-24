repeat()
{
	local i
	local count=$1
	local fail=0
	local tstr
	shift

	if [[ ! "$count" =~ ^[0-9]+$ ]]; then
		echo "Usage: repeat NUMBER COMMAND"
		return
	fi

	for ((i = 1; i <= count; i++)); do
		if [ $fail -gt 0 ]; then
			tstr="$i/$fail/$count"
		else
			tstr="$i/$count"
		fi
		declare -f title > /dev/null && title "$tstr - $@"
		"$@" || : $((fail++))
	done
	[ $fail -gt 0 ] && echo "$count/$fail/$count"
}

