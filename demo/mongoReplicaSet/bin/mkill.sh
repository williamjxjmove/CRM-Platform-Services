#! /bin/bash

# pkill is better, and kill -2 or -15?
ps -ef | grep mongod |grep -v grep | awk '{print $2}' | while read pid 
do 
  kill -15 $pid
done
