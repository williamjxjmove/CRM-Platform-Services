#! /bin/bash
# inits.sh SetB '{ server1:wjiang02vv.corp.homestore.net:60002,   server2: mlinde02vv.corp.homestore.net:60002}'

if [ "$#" -eq 2 ]; then
  repset=$1
  json=$2
else
  echo "Usage: $0 replica_name json_format_server:port_data"
  exit 6
fi


sp=$2
count=1
ff=/tmp/gs${RANDOM}

str="
var cfg = {
 _id:"\"$repset\"",
  members:
  [
"

cc=0
echo $sp | tr "," "\n" | while read x;
do
  i=`echo $x | sed -e "s/^{//" -e "s/}$//" `
  s=`echo $i | cut -d: -f2`
  p=`echo $i | cut -d: -f3`
  st="
  {_id:$cc,host:"\"$s:$p\""},
  "
  echo $st>>$ff
  cc=$((cc+1))
done

str="$str
 `cat $ff`
  ]
}

"
echo "======  1 ======"
echo $str;
echo "================"


echo $sp | tr "," "\n" | while read x
do
  i=`echo $x | sed -e "s/^{//" -e "s/}$//" `
  s=`echo $i | cut -d: -f2`
  p=`echo $i | cut -d: -f3`

  if [ $count = 1 ]; then

  echo '------ 2 ----------'
  echo $s
  echo $p
  echo $str
  echo '-------------------'

mongo $s:$p <<EOF

rs.status();

$str

rs.initiate(cfg);

rs.conf();

EOF

  else

  echo '++++++++ 3 ++++++++'
  echo $s
  echo $p
  echo '+++++++++++++++++++'

mongo $s:$p <<EOF

rs.slaveOk();

rs.status();

EOF
  fi

  count=$((count+1))
done

exit
