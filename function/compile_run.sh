cr()
{
	[ -n "$1" ] || return

	local FILE="$1"

	g++ -g -std=c++11 -pthread -Wall -Wextra -Wpedantic -o "$FILE"{,.cpp} && "./$FILE"
}

