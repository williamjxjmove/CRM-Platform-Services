#! /bin/bash

# wjiang02vv.corp.homestore.net, loclahost, or read from config file?
# port number dynamic assign?
# rs.add('localhost:29102')
# rs.add('localhost:29103')
# rs.initiate()

if [ "$#" -eq 2 ]; then
  port=$1
  repset=$2
else
  echo "Usage: $0 port replica_name"
  exit 6
fi


#{_id:2,host:"aguo02vv.corp.homestore.net:50006",priority:1},
mongo wjiang02vv.corp.homestore.net:$port <<EOF

rs.status()

var cfg = {
  _id:"$repset",
  members:
  [
    {_id:0,host:"wjiang02vv.corp.homestore.net:$port",priority:4},
    {_id:1,host:"mlinde02vv.corp.homestore.net:$port",priority:2},
  ]
}

rs.initiate(cfg);

rs.conf()

EOF

mongo mlinde02vv.corp.homestore.net:$port <<EOF

rs.slaveOk()

rs.conf()

EOF


#mongo aguo02vv.corp.homestore.net:$port <<EOF

#rs.status()
#rs.conf()

#EOF
