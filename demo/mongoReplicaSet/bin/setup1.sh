#! /bin/bash
# Version 1, should be replaced by mongod:/etc/init.d/

# Commandline argument 1 should be base_dir, default is: mongo
if [ "$#" -eq 0 ]; then
  DIR='mongo'
  echo "Use default configuration directory: $HOME/mongo/."
else
  DIR=$1
fi

cd $HOME
[ -d "$DIR" ] || mkdir -p "$DIR"

cd $DIR
[ ! -d m1 ] && mkdir -p m1 m2 m3 log

BASE_DIR=$HOME/$DIR
EXEC_DIR=$HOME/$DIR

echo "No in the directory: <${BASE_DIR}>..."

USER=`whoami`

# For security and permission reason, add current user to 'mongod' group.
# check current user has group attribute of 'mongod'?
id | grep '(mongod)' >/dev/null
if [ $? -eq 0 ]; then
  echo "Current User <$USER> is in group 'mongod'. "
else
  echo "Add current user <$USER> with groupd 'mongod'. "
	sudo usermod -a -G mongod $USER
fi


mongod --config ${EXEC_DIR}/etc/replica_set1.conf

mongod --config ${EXEC_DIR}/etc/replica_set2.conf

mongod --config ${EXEC_DIR}/etc/replica_set3.conf

