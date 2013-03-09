
Currently I used the following 3 servers to test.

## resource servers:
<pre>
- aguo02vv.corp.homestore.net
- mlinde02vv.corp.homestore.net
- wjiang02vv.corp.homestore.net 
</pre>  
  

## get the codes:
Please git pull the source from github.com:


git@github.com:MoveInc/CRM-Platform-Services.git: CRM-Platform-Services / demo / new /


## in the new/ dir:

The following scripts run in different cases:

1) all.sh
<pre>
all.sh
</pre>
will setup 3 different servers by using default values.

<pre>
All the 3 servers will get config at the same time automatically:
Using default setting: 27017 dbpath, logpath etc in /etc/mongod.conf
</pre>

2) other scripts can take input parameters, the sequence like this:

<pre>
# parameters:
#   port-number
#   dbpath
#   dblog
# use /home/movedev/mongo/
</pre>

2) aimin.sh
<pre>
aimin.sh 39999 dbpath dblog.log
</pre>
- will run in aguo02vv.corp.homestore.net:
 mongod --fork --port 39001 --replSet SetA --smallfiles --dbpath /home/movedev/mongo/dbpath --logpath /home/movedev/mongo/dblog.log
 
 
3) mike.sh

<pre>
mike.sh 39999 dbpath dblog.log  
- will run in mlinde02vv.corp.homestore.net:

 mongod --fork --port 39001 --replSet SetA --smallfiles --dbpath /home/movedev/mongo/mg --logpath /home/movedev/mongo/mg.log
 
 
4) william.sh
<pre>
william.sh 3999
</pre>
- will run in wjiang02vv.corp.homestore.net:
 mongod --fork --port 39001 --replSet SetA --smallfiles --dbpath /home/movedev/mongo/mg --logpath /home/movedev/mongo/mg.log
