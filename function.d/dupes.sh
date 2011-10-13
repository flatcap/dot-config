function dups ()
{
	[ $# = 0 ] && set -- .
	find "$@" -name .git -prune -o \( -type f -print0 \) | xargs -r -0 md5sum | sort | uniq --all-repeated=separate -w 32;
}

function dupnames ()
{
	[ $# = 0 ] && set -- .
	find "$@" -name .git -prune -o \( -type f -printf "%-65f%p\n" \) | sort | uniq --all-repeated=separate -w 64;
}

