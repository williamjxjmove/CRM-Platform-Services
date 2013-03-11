#! /bin/bash

if [ "$#" -eq 1 ]; then
  port=$1
else
  echo "Usage: $0 port"
  exit 8
fi

for i in `echo wjiang02vv.corp.homestore.net mlinde02vv.corp.homestore.net aguo02vv.corp.homestore.net`; do

 echo "Start MongoD daemon in <$i>:<$port>"

 echo $i
 echo "===================="

 mongo $i:$port <<EOF

EOF

done

