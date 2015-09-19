#!/bin/bash
# Imports data from OpenDMARC's opendmarc.dat file into a local MySQL DB
# and sends DMARC failure reports to domain owners.
# Based on a script from Hamzah Khan (http://blog.hamzahkhan.com/)

PATH="/usr/bin:/usr/sbin"

set -e

# Database and History File Info
HISTDIR='/var/spool/opendmarc'
HISTFILE='opendmarc'

source /etc/opendmarc/database.sh

# Make sure history file exists
touch ${HISTDIR}/${HISTFILE}.dat

# Move history file temp dir for processing
mv ${HISTDIR}/${HISTFILE}.dat /tmp/${HISTFILE}.$$

# Import temp history file data and send reports
opendmarc-import  -dbhost=${DBHOST} -dbuser=${DBUSER} -dbpasswd=${DBPASS} -dbname=${DBNAME} -verbose < /tmp/${HISTFILE}.$$
opendmarc-reports -dbhost=${DBHOST} -dbuser=${DBUSER} -dbpasswd=${DBPASS} -dbname=${DBNAME} -verbose -interval=86400 -report-email 'postmaster@flatcap.org' -report-org 'flatcap.org'
opendmarc-expire  -dbhost=${DBHOST} -dbuser=${DBUSER} -dbpasswd=${DBPASS} -dbname=${DBNAME} -verbose

# Delete temp history file
rm -f /tmp/${HISTFILE}.$$

