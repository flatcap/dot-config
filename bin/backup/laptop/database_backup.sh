#!/bin/bash

set -o errexit	# set -e
set -o nounset	# set -u

renice --priority 19 --pid $$ > /dev/null
ionice --class 3     --pid $$ > /dev/null

umask 0077

DATE=$(date "+%Y-%m-%d")
RCPT="Rich Russon (backup) <rich@flatcap.org>"
DIR="/mnt/space/backup/database/$DATE"

# if this fails, then the database probably isn't running
DB_LIST=$(mysql --batch -N -e "show databases" 2> /dev/null | grep -v -e information_schema -e mysql -e performance_schema)

mkdir --parents "$DIR"

cd "$DIR"

for i in $DB_LIST; do
	mysqldump "$i" > "$i.sql" 2> /dev/null
	xz --best "$i.sql"
	gpg2 --encrypt --recipient "$RCPT" "$i.sql.xz"
	rm "$i.sql.xz"
done

chown --recursive flatcap:flatcap ..
# chmod --silent 400 *
# chmod --silent 500 .
# chattr +i -R .

