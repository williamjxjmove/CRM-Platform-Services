#!/bin/bash

DIR='mongo'

cd ~/$DIR

if [ -x  ./bin/mkill.sh ]; then
  ./bin//mkill.sh
fi

for i in `echo m1 m2 m3 log`; do 
  sudo rm -rf $i
done

mkdir  m1 m2 m3 log

sudo chgrp -R mongod .

USER=`whoami`

id | grep '(mongod)' >/dev/null
if [ $? -eq 0 ]; then
  echo "Current User <$USER> is in group 'mongod'. "
else
	echo "Add current user <$USER> with groupd 'mongod'. "
	sudo usermod -a -G mongod $USER
fi

