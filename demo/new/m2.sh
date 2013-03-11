#! /bin/bash

server="mlinde02vv.corp.homestore.net"

if [ "$#" -eq 1 ]; then
  port=$1
fi

mongo $server:$port <<EOF

rs.status()

var cfg = {
  _id:"SetA",
  members:
  [
    {_id:0,host:"$server",priority:4},
  ]
}
rs.initiate(cfg);
rs.conf()

EOF
