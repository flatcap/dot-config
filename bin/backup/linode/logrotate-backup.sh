#!/bin/sh

FROM="/var/log/ /var/named/data"
TO="/backup/linode/log"
RCPT="Rich Russon (backup) <rich@flatcap.org>"

mkdir --parents "$TO"

# Move files from the log dirs into /backup/log (maintaining the directory hierarchy).
rsync --archive --prune-empty-dirs --remove-source-files --include '*/' --include '*.gz'        --exclude '*' $FROM $TO
rsync --archive --prune-empty-dirs --remove-source-files --include '*/' --include '*@*.journal' --exclude '*' $FROM $TO

find "$TO" -type f ! -name \*.gpg -print0 | xargs --no-run-if-empty -0 -n 1 gpg --encrypt --recipient "$RCPT"

# RISKY!  Ought to check that the encryption stage succeeded.
find "$TO" -type f ! -name \*.gpg -print0 | xargs --no-run-if-empty -0 rm

find "$TO" -type f -perm -200 -print0 | xargs --no-run-if-empty -0 chmod og-rwx,u-w

