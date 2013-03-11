#! /bin/bash

if [ "$#" -eq 1 ]; then
  port=$1
else 
 echo "Usage: $0 port_number"
 exit
fi


START=$(date +%s)

for (( ; ; ))
do

echo 'rs.status()' | mongo mlinde02vv.corp.homestore.net:$port | grep stateStr | grep SECONDARY >/dev/null
[ $? = 0 ] && f1=1

echo 'rs.status()' | mongo wjiang02vv.corp.homestore.net:$port | grep stateStr | grep PRIMARY >/dev/null
[ $? = 0 ] && f2=2


if [ $f1 == '1'  -a $f2 == '2' ]; then
mongo wjiang02vv.corp.homestore.net:$port <<EOF
  rs.status()
EOF

mongo mlinde02vv.corp.homestore.net:$port <<EOF
rs.status()
EOF
 echo "The MongoDB replica Set has already been initialized succesfully."
 END=$(date +%s)
 DIFF=$(( $END - $START ))
 echo "------------------------"
 echo "It took <$DIFF> seconds."
 exit 8
fi

#mongo aguo02vv.corp.homestore.net:$port <<EOF
#rs.status()
#EOF

sleep 3

END=$(date +%s)
DIFF=$(( $END - $START ))

if [ $DIFF > 30 ];then

mongo wjiang02vv.corp.homestore.net:$port <<EOF
  rs.status()
EOF

mongo mlinde02vv.corp.homestore.net:$port <<EOF
rs.status()
EOF


 echo "Expired."
 exit
fi

done
