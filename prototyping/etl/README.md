# ETL

### Install FREETDS 
vi /etc/yum.repos.d/epel.repo

	[epel]
	name=Extra Packages for Enterprise Linux 6 - $basearch
	#baseurl=http://download.fedoraproject.org/pub/epel/6/$basearch
	mirrorlist=https://mirrors.fedoraproject.org/metalink?repo=epel-6&arch=$basearch
	failovermethod=priority
	enabled=0
	gpgcheck=0
	
sudo yum install freetds freetds-devel --enablerepo=epel 

### Install Gems

sudo bundle install

### Configure file: config.yaml
$$
$$
$$