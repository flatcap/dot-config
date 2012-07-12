#!/bin/bash

cd ~root

TMPFILE=$(mktemp)

rpm -qa --qf "%{installtime}\t%{installtime:date}\t%{arch}\t%{group}\t%{name}\t%{release}\t%{size}\t%{version}\n" > $TMPFILE

# rpm -qa --qf "%{name}-%{version}-%{release}.%{arch}\n" | sort
awk -F'	' '{ print $5"-"$8"-"$6"."$3 }' $TMPFILE | sort > rpm_list

# rpm -qa --qf "%{group} %{name}\n" | sort
awk -F'	' '{ print $4" "$5 }' $TMPFILE | sort > rpm_group

# rpm -qa --qf "%{size} %{name}\n"  | sort -nr
awk -F'	' '{ print $7" "$5 }' $TMPFILE | sort -nr > rpm_size

# rpm -qa --qf "%{installtime} %{installtime:date} %{name}-%{version}-%{release}\n" | sort -nr
sort -nr $TMPFILE | awk -F'	' '{ print $2" "$5"-"$8"-"$6 }' > rpm_last

rm -f $TMPFILE

