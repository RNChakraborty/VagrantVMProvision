#!/bin/bash


mysql_prov(){
msql=$( command -v mysql );
if [ -z "$msql" ]; then
  sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password pythian'
  sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password pythian'
  sudo apt-get install -y mysql-server >/dev/null 2>&1
  echo "Finished Installing Mysql!!!"
  touch dbcreate
fi
}
github_prov(){
githb=$( command -v git );
if [ -z "$githb" ]; then
  sudo apt-get install -y git >/dev/null 2>&1
  echo "Finished Installing Github!!!"
  touch gitcreate
fi
}

echo "****Started Provisioning*****\n"
sudo apt-get update >/dev/null 2>&1
mysql_prov
github_prov