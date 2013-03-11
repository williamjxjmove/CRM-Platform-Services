

## resource servers:
<pre>
- aguo02vv.corp.homestore.net
- mlinde02vv.corp.homestore.net
- wjiang02vv.corp.homestore.net 
</pre>  
  

## get the codes:
Please git pull the source from github.com:


git@github.com:MoveInc/CRM-Platform-Services.git: CRM-Platform-Services / demo / reqs /


## in the reqs/ dir:

The following scripts run in different cases:

1) all1.sh port_number replica_name
or more specific:
sudo ./start1.sh server port replica_name
<pre>
all1.sh port_number replica_name
e.g:
$ all1.sh 50110 SetA
</pre>
will setup 3 different servers by using '50110' port.

2) init2.sh
inits.sh port_number replica_name
<pre>
inits.sh 50111 SetA
</pre>
- will run:
 mongod --fork --port 50111 --replSet SetA --smallfiles --dbpath /usr/local/lib/db_SetA_50111 --logpath /usr/local/log/log_SetA_50111/log_SetA_50111.log
 
 
## Monitor (mm3.sh and monitor.sh)
3) mm3.sh
<pre>
mm3.sh 50111
</pre>
- will loop 30 seconds to check the init status.
If it is done, the script will return the final rs.stauts(), if not, will display the un-finished message and quit within 30 seconds.
