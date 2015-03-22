#!/bin/bash

umask 022

cd "${0%/*}"

TMPFILE=$(mktemp)

rpm -qa --qf "%{installtime}\t%{installtime:date}\t%{arch}\t%{group}\t%{name}\t%{release}\t%{size}\t%{version}\n" > $TMPFILE

# rpm -qa --qf "%{name}-%{version}-%{release}.%{arch}\n" | sort
awk -F'	' '{ print $5"-"$8"-"$6"."$3 }' $TMPFILE | sort > rpm-list

# rpm -qa --qf "%{group} %{name}\n" | sort
awk -F'	' '{ print $4" "$5 }' $TMPFILE | sort > rpm-group

# rpm -qa --qf "%{size} %{name}\n"  | sort -nr
awk -F'	' '{ print $7" "$5 }' $TMPFILE | sort -nr > rpm-size

# rpm -qa --qf "%{installtime} %{installtime:date} %{name}-%{version}-%{release}\n" | sort -nr
sort -nr $TMPFILE | awk -F'	' '{ print $2" "$5"-"$8"-"$6 }' > rpm-last

rm -f $TMPFILE

