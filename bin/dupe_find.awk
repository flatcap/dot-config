BEGIN {
	old = "";
}

{
	sum = $1;
	#printf ("sum = %s\n", sum);

	if (sum != old) {
		if (NR > 1) {
			print "";
		}
		old = sum;
	}

	print substr ($0, 37);
}

END {
	print "";
}

