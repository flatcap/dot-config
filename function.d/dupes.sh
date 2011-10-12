function dupes ()
{
	[ $# = 0 ] && set -- .
	find "$@" -type f -exec md5sum '{}' ';' | sort | uniq --all-repeated=separate -w 32;
}
