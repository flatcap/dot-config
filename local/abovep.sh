abovep()
{
	#local PANEL="Top Expanded Edge Panel"
	#local PANEL="Bottom Expanded Edge Panel"
	local PANEL="Top Panel"

	wmctrl -r "$PANEL" -b remove,below
}

