repeat()
{
	local i
	local count=$1
	shift
	for ((i = 1; i <= count; i++)); do
		declare -f title > /dev/null && title "$i - $@"
		"$@"
	done
}

