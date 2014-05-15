qd()
{
	[ $# = 0 ] && return;
	mysql --batch -N -e "$*";
}
