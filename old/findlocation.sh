findlocation()
{
	place=$(echo $@ | sed 's/ /%20/g');
	curl -s "http://maps.google.com/maps/geo?q=$place" | grep -e "address" -e "coordinates" | sed -e 's/^ *//' -e 's/"//g';
}
