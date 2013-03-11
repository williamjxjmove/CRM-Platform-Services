#! /bin/bash

server="wjiang02vv.corp.homestore.net"

if [ "$#" -eq 1 ]; then
  port=$1
fi


mongo $server:$port <<EOF


rs.slaveOk()

EOF


