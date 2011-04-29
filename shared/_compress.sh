_compress()
{
	local OPTIONS=""
	local COUNT=0
	local LOOP=1
	local i
	local COMPRESS=$1
	local BASE=$(basename $COMPRESS)

	shift

	for i in "$@"; do
		case "$i" in
			--)	break;;
			-)	COUNT=$((COUNT+1));;
			-*)	OPTIONS="$OPTIONS $i";;
			*)	COUNT=$((COUNT+1));;
		esac
	done

	for i in "$@"; do
		[[ "$i" == -* ]] && continue;
		TITLE="$BASE $OPTIONS $i"
		[ $COUNT -gt 1 ] && TITLE="$TITLE ($LOOP/$COUNT)"
		title $TITLE
		$COMPRESS $OPTIONS "$i"
		LOOP=$((LOOP+1))
	done

	title
}
