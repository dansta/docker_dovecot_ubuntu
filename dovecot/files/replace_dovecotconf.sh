#!/bin/bash
# set up env
set -e

CONF="/etc/dovecot/dovecot.conf"
CONFDATA="$(cat $CONF)"
KEYAWK="/usr/bin/awk -f /usr/local/bin/key.awk"
VALUEAWK="/usr/bin/awk -f /usr/local/bin/value.awk"


# get all the dovecotvars
DOVECOTENV="$(env | grep DOVECOT)"

# for each dovecotvar, replace them in the file
for i in $DOVECOTENV; do
  CONFDATA="$(echo -e "$CONFDATA" | sed s/"$(echo $i | $KEYAWK)"/"$(echo $i | $VALUEAWK)"/g )"
done

#clear out all comments and write to file
echo -e $CONFDATA | sed /^#.*$/d > "$CONF"

