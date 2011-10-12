function dupes ()
{
	[ $# = 0 ] && set -- .
	find "$@" -name .git -prune -o \( -type f -print0 \) | xargs -r -0 md5sum | sort | uniq --all-repeated=separate -w 32;
}

