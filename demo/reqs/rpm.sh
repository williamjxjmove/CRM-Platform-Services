#! /bin/bash

cd $HOME/gs/demo/

tar czvf ~/rpmbuild/SOURCES/reqs-1.0.tar.gz reqs

cd ~/rpmbuild/SPECS

rpmbuild -bs reqs.spec

cd ~/rpmbuild/SRPMS/

cp reqs-1.0-1.el6.src.rpm ~/gs/demo/reqs/

echo "Done to generate req-1.0.src.rpm"
