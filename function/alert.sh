function alert()
{
	local COUNT;
	[ $# = 1 ] && COUNT=$1 || COUNT=1
	(repeat $COUNT play --volume 0.1250 /usr/share/sounds/gnome/default/alerts/glass.ogg &) &> /dev/null
}

export -f alert

