#!/bin/bash

DIR='mongo'
if [ -d "$DIR" ]; then
  echo 'Bingo'
fi


USERID="$1"
/bin/egrep -i "^${USERID}" /etc/passwd
if [ $? -eq 0 ]; then
  echo "User $USERID exists in /etc/passwd"
else
  echo "User $USERID does not exists in /etc/passwd"
fi
