#!/bin/bash


mysql_prov(){
sudo apt-get update >/dev/null 2>&1
msql=$( command -v mysql );
if [ -z "$msql" ]; then
  sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password pythian'
  sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password pythian'
  sudo apt-get install -y mysql-server >/dev/null 2>&1
  echo "Finished Installing Mysql!!!"
  touch dbcreate
fi
}

echo "****Started Provisioning*****\n"
mysql_prov
