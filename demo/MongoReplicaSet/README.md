
# Quick start

## 1. Get the codes:

    $ cd ~
    $ git clone git@github.com:MoveInc/CRM-Platform-Services.git

## 2. Processing steps:

    $ cd CRM-Platform-Services/demo/MongoReplicaSet/
    $ export PATH=$PAH:.
    $ all1.sh  port_number replica_name 
    $ inits.sh replica_name 'json_format servers list'
    $ mm3.sh server port

That's it!

---------------------------------------------------------------------------

## 3. More details about processing:

More explains and details for above processing steps:

` $ cd CRM-Platform-Services/demo/MongoReplicaSet/ ` to the clone processing directory.

` $ export PATH=$PAH:. ` is optional. It sets environment variable $PATH to include **current path**.

` $ all1.sh  port_number replica_name  `.
all1.sh is the first script to call. Basically it does:
* it receives 2 parameters:
  + port number
  + replica name, default is 'SetA'.
* check input parameters are correct, adding default if need.
* setup default servers to run Replica-Set. **If default server needs to change, please modify here.**
* call the script start1.sh to run: ` start1.sh $server $port $replica_name`


` $ inits.sh replica_name 'json_format servers list'`
inits.sh is the second script to call, Basically it looks something like this:
    $ inits.sh SetB '{ server1:wjiang02vv.corp.homestore.net:60002, server2: mlinde02vv.corp.homestore.net:60002}'
* it receives 2 parameters:
  + replica name
  + Replica Set servers list.
* check input parameters are correct, each server include server_name and port_name.
* setup mongo initializing parameters according to inputs.
* call `mongo` to initialize Replica-Set Servers.
* This script will init the first json object, here is ‘wjiang02vv.corp.homestore.net’ as primary, and the following are ‘secondary’.

` $ mm3.sh server port ` to monitor the init processing.
will loop 30 seconds to check the init status.
If it is done, the script will return the final rs.stauts(), if not, will display the un-finished message and quit within 30 seconds.


## 3. Examples:

Let's say we have the following 3 servers, and want to use 'SetB' as ReplcaSet name, and  60002 as port number:

### resource servers:
    - aguo02vv.corp.homestore.net
    - mlinde02vv.corp.homestore.net
    - wjiang02vv.corp.homestore.net 
  
### The processing steps:

    $ cd CRM-Platform-Services/demo/MongoReplicaSet

* startup MongoD servers:

    $ all1.sh  60002 SetB 

It calls `start1.sh` to run replicaSet name=”SetB” and port “60002” in all the 3 servers.
Since `all1.sh` calls `start1.sh`, an optional step to replace `all1.sh` is:
    $ start1.sh mlinde02vv.corp.homestore.net 60002 SetB
    $ start1.sh wjiang02vv.corp.homestore.net 60002 SetB
    $ start1.sh aguo02vv.corp.homestore.net 60002 SetB
This will startup the 3 servers also, same as `all1.sh`.

* init Replica-Set mongoD servers:
    $ inits.sh SetB '{ server1:wjiang02vv.corp.homestore.net:60002, server2: mlinde02vv.corp.homestore.net:60002, server3: aguo02vv.corp.homestore.net:60002}'
The first json-item, ‘wjiang02vv.corp.homestore.net’ will be inited as primary server, and the following are ‘secondary’ servers.

There is an option for `inits.sh` too, **init2.sh**, which syntax is:
    $ init2.sh server1:port1 server2:port2 replica_name

So the follow can replace the above `inits.sh`:
    $ init2.sh wjiang02vv.corp.homestore.net:60002 mlinde02vv.corp.homestore.net:60002 aguo02vv.corp.homestore.net:60002 SetB

* monitor the processing:
    $ mm3.sh mlinde02vv.corp.homestore.net 60002 

---------------------------------------------------------------------------

# Explain:

In the CRM-Platform-Services/demo/MongoReplicaSet directory, there are the following scripts available:

* all1.sh

Syntax:  
    $ all1.sh port_number replica_name

An example:  
    $ all1.sh 60002 SetA
will run:
    mongod --fork --port 60002 --replSet SetA --smallfiles --dbpath /usr/local/lib/db_SetA_60002 --logpath /usr/local/log/log_SetA_60002/log_SetA_60002.log

* start1.sh (calls by all1.sh)

* inits.sh (accept json data)

An example:
    $ inits.sh SetB '{ server1:wjiang02vv.corp.homestore.net:60002, server2: mlinde02vv.corp.homestore.net:60002}'

The parameter format:
   {server1: server:port,
    Server2: server:port,
    Server3:server:port,
    ……
   }

* init2.sh (an option for inits.sh, which accepts non-json parameter)

Syntax:
    $ init2.sh server1:port1 server2:port2 replica_name

An example:
    $ init2.sh wjiang02vv.corp.homestore.net:60002 mlinde02vv.corp.homestore.net:60002 SetA

* mm3.sh

* monitor.sh (an option by mm3.sh, which loop all replicaSet servers, not just 1)

mm3.sh and monitor.sh all do monitoring.  
mm3.sh runs in 1 server to monitor, while monitor.sh monitor all ReplicaSet Servers.   
**mm3.sh** is prior to monitor.sh. 
    $ mm3.sh  mlinde02vv.corp.homestore.net 60002

* rpm.sh (rpm generator)
    $ rpm.sh

This is a script reqs/rpm.sh to generate reqs-1.0.src.rpm file automatically.
    $ ./rpm.sh

The configure file is solid in ~/rpmbuild/SPECS/reqs.spec  
The rpm.sh pack the tar.gz and use 'rpmbuild' to generate rpm file, and move it to reqs directory.  
At anytime, this script can be run to generate latested version for rpm file. 

Besides, some support files:

* README.md (this file)
* reqs-1.0-1.el6.src.rpm (rpm.sh generated package)
* server.json (an example of how the inits.sh input parameter looks like)

