#! /bin/bash

# wjiang02vv.corp.homestore.net, loclahost, or read from config file?
# port number dynamic assign?
# rs.add('localhost:29102')
# rs.add('localhost:29103')
# rs.initiate()

mongo --port 29101 <<EOF

rs.status()

var cfg = {
  _id:"MoveGS",
  members:
  [
    {_id:0,host:"127.0.0.1:29101",priority:4},
    {_id:1,host:"127.0.0.1:29102",priority:2},
    {_id:2,host:"127.0.0.1:29103",arbiterOnly : true}
  ]
}
rs.initiate(cfg);
rs.conf()

EOF

mongo localhost:29102 <<EOF

rs.slaveOk()

EOF


# What do for the third Mongo Server?
# rs.initiate()
mongo localhost:29103 <<EOF

rs.status()

EOF
