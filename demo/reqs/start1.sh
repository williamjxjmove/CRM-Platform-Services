#! /bin/bash

id | grep 'uid=0' >/dev/null
if [ $? != 0 ]; then
 echo "You need to be 'root' to run this command: "
 echo "  sudo $0 server port replica_name"
 exit 2
fi


if [ $# != 3 ]; then
 echo "Usage: sudo $0 server port replica_Name"
 exit 3
else
  server=$1
  port=$2
  repset=$3
fi

DBDIR="db_${repset}_$port"
LOGDIR="log_${repset}_$port"

echo "dbpath is in: /usr/local/lib/$DBDIR"
echo "logpath is in: /usr/local/lib/$LOGDIR"

ssh $server  <<EOF

ps -ef | grep mongod | grep $port | grep -v grep | awk '{print $2}' | while read pid
do
  echo "The port is being used. Change to other port."
  exit 4
done

pkill mongod

cd  /usr/local/lib/

if [ -d "$LOGDIR" ]; then
  rm -rf $LOGDIR/*
else
  rm -rf /usr/local/lib/log_*
  mkdir -p $LOGDIR
fi

if [ -d "$DBDIR" ]; then
  rm -rf $DBDIR/*
else
  rm -rf /usr/local/lib/db_*
  mkdir -p $DBDIR
fi

mongod --fork --port $port --replSet $repset --smallfiles --dbpath /usr/local/lib/$DBDIR --logpath /usr/local/lib/$LOGDIR/$LOGDIR.log

echo "======================================"
echo "MongoD is running on <$server>:<$port>"
echo "======================================"
echo

ps -ef | grep mongod | grep -v grep

EOF
