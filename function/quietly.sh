function q()
{
	"$@" 2> /dev/null;
}

function qq()
{
	"$@" 2> /dev/null > /dev/null;
}

export -f q
export -f qq
