#! /bin/bash

cd $HOME/gs/demo/

tar czvf ~/rpmbuild/SOURCES/MongoReplicaSet-1.0.tar.gz MongoReplicaSet

cd ~/rpmbuild/SPECS

rpmbuild -bs MongoReplicaSet.spec

cd ~/rpmbuild/SRPMS/

cp MongoReplicaSet-1.0-1.el6.src.rpm ~/gs/demo/MongoReplicaSet/

echo "Done to generate MongoReplicaSet-1.0.src.rpm"
