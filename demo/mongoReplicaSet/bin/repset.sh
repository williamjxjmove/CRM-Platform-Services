#!/bin/bash
# $0 - Startup script for mongod replica set
# $Id$

. /etc/rc.d/init.d/functions

BASEDIR='/home/movedev/mongo'
SYSCONFIG="/etc/sysconfig/mongod"
mongod=${MONGOD-/usr/bin/mongod}
MONGO_USER=mongod
MONGO_GROUP=mongod


### 1. primary ###
CONFIGFILE1=${BASEDIR}/etc/replica_set1.conf
OPTIONS1=" -f $CONFIGFILE1"
DBPATH1=`awk -F= '/^dbpath=/{print $2}' "$CONFIGFILE1"`
PIDFILE1=`awk -F= '/^dbpath\s=\s/{print $2}' "$CONFIGFILE1"`


### 2. seconary ###
CONFIGFILE2=${BASEDIR}/etc/replica_set2.conf
OPTIONS2=" -f $CONFIGFILE2"
DBPATH2=`awk -F= '/^dbpath=/{print $2}' "$CONFIGFILE2"`
PIDFILE2=`awk -F= '/^dbpath\s=\s/{print $2}' "$CONFIGFILE2"`

### 3. seconary ###
CONFIGFILE3=${BASEDIR}/etc/replica_set3.conf
OPTIONS3=" -f $CONFIGFILE3"
DBPATH3=`awk -F= '/^dbpath=/{print $2}' "$CONFIGFILE3"`
PIDFILE3=`awk -F= '/^dbpath\s=\s/{print $2}' "$CONFIGFILE3"`


# '/etc/sysconfig/mongod' is nothing.
if [ -f "$SYSCONFIG" ]; then
    . "$SYSCONFIG"
fi

NUMACTL_ARGS="--interleave=all"
if which numactl >/dev/null 2>/dev/null && numactl $NUMACTL_ARGS ls / >/dev/null 2>/dev/null
then
    NUMACTL="numactl $NUMACTL_ARGS"
else
    NUMACTL=""
fi

start()
{
  echo -n $"Starting mongod primary <1>: "
  daemon --user "$MONGO_USER" $NUMACTL $mongod $OPTIONS1
  RETVAL=$?
  echo
  [ $RETVAL -eq 0 ] && touch /home/movedev/mongo/m1/mongod1.pid

  echo -n $"Starting mongod secondary <2>: "
  daemon --user "$MONGO_USER" $NUMACTL $mongod $OPTIONS2
  RETVAL=$?
  echo
  [ $RETVAL -eq 0 ] && touch /home/movedev/mongo/m2/mongod2.pid


  echo -n $"Starting mongod secondary <3>: "
  daemon --user "$MONGO_USER" $NUMACTL $mongod $OPTIONS3
  RETVAL=$?
  echo
  [ $RETVAL -eq 0 ] && touch /home/movedev/mongo/m3/mongod3.pid

  echo "Currently Mongod Running Status: "
  echo "---------------------------------"
	ps -ef | grep mongod | grep -v grep
}

stop()
{
  echo -n $"Stopping mongod: "
  killproc -p "$PIDFILE" -d 300 /usr/bin/mongod
  RETVAL=$?
  echo
  [ $RETVAL -eq 0 ] && {
		rm -f /home/movedev/mongo/m1/mongod1.pid
		rm -f /home/movedev/mongo/m2/mongod2.pid
		rm -f /home/movedev/mongo/m3/mongod3.pid
	}
}

restart () {
	stop
	start
}

ulimit -n 12000
RETVAL=0

case "$1" in
  start)
    start
    ;;
  stop)
    stop
    ;;
  restart|reload|force-reload)
    restart
    ;;
  status)
    status $mongod
    RETVAL=$?
    ;;
  *)
    echo "Usage: $0 {start|stop|status|restart|reload|force-reload}"
    RETVAL=1
esac

exit $RETVAL
