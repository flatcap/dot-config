#quietly
#	q() { "$*" > /dev/null 2>&1; };
#	function q () { "$@" ; }
#	function q () { $* 2>&1 ; }
#	function qq () { $* 2> /dev/null > /dev/null; }
#	quietly() { "$@" |&:; }
#	quietly() { "$@" > /dev/null 2>&1; }
#	one quiet, one very quiet
#
#	function qq () { $* 2> /dev/null > /dev/null; }
#
function q ()  { "$@" 2> /dev/null; }
function qq () { "$@" 2> /dev/null > /dev/null; }
