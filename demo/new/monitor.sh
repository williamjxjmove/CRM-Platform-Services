#! /bin/bash

if [ "$#" -eq 1 ]; then
  port=$1
else 
 echo "Usage: $0 port_number"
 exit
fi



for (( ; ; ))

do

mongo mlinde02vv.corp.homestore.net:$port <<EOF

rs.status()

EOF

mongo wjiang02vv.corp.homestore.net:$port <<EOF

rs.status()

EOF


mongo aguo02vv.corp.homestore.net:$port <<EOF

rs.status()

EOF

sleep 5

echo "========================"
echo "Loop in every 5 seconds:"

done
