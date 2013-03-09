#!/bin/bash

# parameters:
#   port-number
#   dbpath
#   dblog
# use /home/movedev/mongo/

if [ "$#" -eq 1 ]; then
  port=$1
  dbpath=mg
  dblog="mg.log"
fi
if [ "$#" -eq 2 ]; then
  port=$1
  dbpath=$2
  dblog="mg.log"
fi
if [ "$#" -eq 3 ]; then
  port=$1
  dbpath=$2
  dblog=$3
fi

ssh movedev@mlinde02vv.corp.homestore.net <<EOF

pkill mongod

cd /home/movedev/
[ -d "mongo" ] || mkdir -p mongo

cd /home/movedev/mongo

rm -rf /home/movedev/mongo/*

[ -d "/home/movedev/mongo/$dbpath" ] || mkdir -p /home/movedev/mongo/$dbpath


mongod --fork --port $port --replSet SetA --smallfiles --dbpath /home/movedev/mongo/$dbpath --logpath /home/movedev/mongo/$dblog


ps -ef | grep mongod | grep -v grep

EOF

