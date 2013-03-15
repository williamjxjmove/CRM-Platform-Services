#! /bin/bash
# mm3.sh mlinde02vv.corp.homestore.net 60001

if [ "$#" -eq 2 ]; then
  server=$1
  port=$2
else 
 echo "Usage: $0 server port_number"
 exit
fi


START=$(date +%s)
f1=0
f2=0
for (( ; ; ))
do

mongo $server:$port <<EOF
  rs.status()
EOF


echo 'rs.status()' | mongo $server:$port | grep stateStr | grep SECONDARY >/dev/null
[ $? = 0 ] && f1=1

echo 'rs.status()' | mongo $server:$port | grep stateStr | grep PRIMARY >/dev/null
[ $? = 0 ] && f2=2


if [ $f1 -eq 1 -a $f2 -eq 2 ]; then

 echo "The MongoDB replica Set has already been initialized succesfully."
 END=$(date +%s)
 DIFF=$(( $END - $START ))
 echo "------------------------"
 echo "It took <$DIFF> seconds."
 exit 8
fi

sleep 3

END=$(date +%s)
DIFF=$(( $END - $START ))

if (( "$DIFF" > 30 ));then
 echo "Expired."
 exit
fi

done
