#! /bin/bash

id | grep 'uid=0' >/dev/null
if [ $? != 0 ]; then
 echo "You need to be 'root' to run this command: "
 echo "  sudo $0 server port"
 exit 2
fi


if [ $# != 2 ]; then
 echo "Usage: sudo $0 server port"
 exit 3
else
  server=$1
  port=$2
fi

MGDIR='mongo'

ssh $server  <<EOF

ps -ef | grep mongod | grep $port | grep -v grep | awk '{print $2}' | while read pid
do
  echo "The port is being used. Change to other port."
  exit 4
done

pkill mongod

cd  /home/movedev/

[ -d "$MGDIR" ] || mkdir -p "$MGDIR"
cd $MGDIR

if [ -d "mg" ]; then
  rm -rf mg/*
else
  mkdir -p mg
fi
if [ -d "log" ]; then
  rm -rf log/*
else
  mkdir -p log
fi

mongod --fork --port $port --replSet SetA --smallfiles --dbpath mg --logpath log/mg.log

echo "======================================"
echo "MongoD is running on <$server>:<$port>"
echo "======================================"
echo

ps -ef | grep mongod | grep -v grep

EOF
