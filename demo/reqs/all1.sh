#! /bin/bash

if [ "$#" -eq 1 ]; then
  port=$1
else
  echo "Usage: $0 port"
  exit 8
fi

#echo movedev@wjiang02vv.corp.homestore.net movedev@mlinde02vv.corp.homestore.net movedev@aguo02vv.corp.homestore.net;

for i in `echo root@wjiang02vv.corp.homestore.net root@mlinde02vv.corp.homestore.net root@aguo02vv.corp.homestore.net`; do

 echo "-----------------------------------"
 echo "Start MongoD daemon in <$i>:<$port>"
 echo "-----------------------------------"

 sudo ./start1.sh $i $port

done

