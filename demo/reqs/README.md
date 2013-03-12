
## resource servers:
<pre>
- aguo02vv.corp.homestore.net
- mlinde02vv.corp.homestore.net
- wjiang02vv.corp.homestore.net 
</pre>  
  

## get the codes:
Please git pull the source from github.com:


git@github.com:MoveInc/CRM-Platform-Services.git: CRM-Platform-Services / demo / reqs /

Useful scripts:
<pre>
all1.sh  port replica_name 
start1.sh server port replica_name
init2.sh server1:port1 server2:port2 replica_name 
mm3.sh server port
</pre>


## in the reqs/ dir:

The following scripts run in different cases:

1) all1.sh port_number replica_name <br>
or more specific:<br>
sudo ./start1.sh server port replica_name
<pre>
$ all1.sh port_number replica_name
e.g:
$ all1.sh 50111 SetA
</pre>

will run:
<pre>
mongod --fork --port 50111 --replSet SetA --smallfiles --dbpath /usr/local/lib/db_SetA_50111 --logpath /usr/local/log/log_SetA_50111/log_SetA_50111.log
</pre> 

2) init2.sh
init2.sh server1:port1 server2:port2 replica_name
<pre>
$ init2.sh wjiang02vv.corp.homestore.net:50111 mlinde02vv.corp.homestore.net:50111 SetA

</pre>
will setup different servers by using '50111' port: primary and secondary.
 
## Monitor (mm3.sh and monitor.sh)
3) mm3.sh  mlinde02vv.corp.homestore.net 50111
<pre>
$ mm3.sh 50111
</pre>

will loop 30 seconds to check the init status.

If it is done, the script will return the final rs.stauts(), if not, will display the un-finished message and quit within 30 seconds.

## RPM generator
There is a script reqs/rpm.sh to generate reqs-1.0.src.rpm file automatically.

<pre>
$ ./rpm.sh
</pre>

The configure file is solid in ~/rpmbuild/SPECS/reqs.spec
The rpm.sh pack the tar.gz and use 'rpmbuild' to generate rpm file, and move it to reqs directory.

At anytime, this script can be run to generate latested version for rpm file.
