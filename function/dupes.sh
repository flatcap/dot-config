function dupnames ()
{
	[ $# = 0 ] && set -- .
	find "$@" -name .git -prune -o \( -type f -printf "%-65f%p\n" \) | sort | uniq --all-repeated=separate -w 64;
}

