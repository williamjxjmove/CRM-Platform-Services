##! /bin/bash

#id | grep 'uid=0' >/dev/null
#if [ $? != 0 ]; then
# echo "You need to be 'root' to run this command: "
# echo "  sudo $0 server port"
# exit 2
#fi


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

cd  /home/movedev/
MGDIR='mongo'

[ -d "$MGDIR" ] || mkdir -p "$MGDIR"
cd $MGDIR

[ -d "mg" ] || mkdir -p "mg"
[ -d "log" ] || mkdir -p "log"

mongod --fork --port $port --replSet SetA --smallfiles --dbpath mg --logpath log/mg.log

echo "-------------------------------------"
echo "MongoD is running on <$server>:<$port>"
echo

ps -ef | grep mongod | grep -v grep

EOF
