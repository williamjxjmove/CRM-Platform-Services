#! /bin/bash
# all1.sh 60002 SetB

if [ "$#" -eq 1 ]; then
  port=$1
  replica_name=SetA
elif [ "$#" -eq 2 ]; then
  port=$1
  replica_name=$2
else
  echo "Usage: $0 port replica_name"
  exit 8
fi

#echo movedev@wjiang02vv.corp.homestore.net movedev@mlinde02vv.corp.homestore.net movedev@aguo02vv.corp.homestore.net;

for i in `echo root@wjiang02vv.corp.homestore.net root@mlinde02vv.corp.homestore.net root@aguo02vv.corp.homestore.net`; do

 echo "-----------------------------------"
 echo "Start MongoD daemon in <$i>:<$port>"
 echo "-----------------------------------"

 sudo ./start1.sh $i $port $replica_name

done

