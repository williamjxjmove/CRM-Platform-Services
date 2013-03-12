#! /bin/bash

# wjiang02vv.corp.homestore.net, loclahost, or read from config file?
# port number dynamic assign?
# rs.add('localhost:29102')
# rs.add('localhost:29103')
# rs.initiate()

if [ "$#" -eq 3 ]; then
  sp1=$1
  sp2=$2
  repset=$3
else
  echo "Usage: $0 server1:port1 server2:port2 replica_name"
  exit 6
fi

s1=`echo $sp1 | cut -d: -f1`
p1=`echo $sp1 | cut -d: -f2`

s2=`echo $sp2 | cut -d: -f1`
p2=`echo $sp2 | cut -d: -f2`

if [ $p2 == '' ]; then
  echo "Usage: $0 server1:port1 server2:port2 replica_name"
  echo "Please input port number";
  exit 6
fi

echo $s1', '$p1
echo $s2', '$p2
echo $repset

mongo $s1:$p1 <<EOF

rs.status()

var cfg = {
  _id:"$repset",
  members:
  [
    {_id:0,host:"$s1:$p1",priority:4},
    {_id:1,host:"$s2:$p2",priority:2},
  ]
}

rs.initiate(cfg);

rs.conf()

EOF

mongo $s2:$p2 <<EOF

rs.slaveOk()

rs.conf()

EOF


#mongo aguo02vv.corp.homestore.net:$port <<EOF

#rs.status()
#rs.conf()

#EOF
