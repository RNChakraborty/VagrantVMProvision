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
apache_prov(){
apache=$( command -v apache2 );
if [ -z "$apache" ]; then
  sudo apt-get install -y apache2 >/dev/null 2>&1
  echo "Finished Installing Apache!!!"
  touch apachecreate
fi

}

check_installation(){
 msql=$( command -v mysql );
 apache=$( command -v apache2 );
 githb=$( command -v git );
 msql_print=''
 apache_print=''
 github_print=''
 all_installation_complete='true'
 
 if [ -z "$githb" ]; then
     github_print='Not Installed!'
	 all_installation_complete='false'
 else
    github_print='Installed'
 fi
 
 if [ -z "$msql" ]; then
     msql_print='Not Installed!'
	 all_installation_complete='false'
 else
    msql_print='Installed'
 fi
 
if [ -z "$apache" ]; then
     apache_print='Not Installed!'
	 all_installation_complete='false'
 else
    apache_print='Installed'
 fi
  echo "Github..."$github_print
  echo "MySql..."$msql_print
  echo "Apache..."$apache_print
 
 if [[ "$all_installation_complete" = "true" ]]; then
     echo "All installation completed !!! Preparing to clone a sample git repository"
 else
    echo "Problem with installation. Aborting !!!!"
 fi
}

prepare_directory_and_clone_git(){
sudo addgroup pythian >/dev/null 2>&1
sudo useradd pythian -g pythian
echo pythian:pythian123 | chpasswd
sudo mkdir /opt/code/
sudo git clone git://github.com/RNChakraborty/SystemINFO.git /opt/code/ >/dev/null 2>&1
sudo chown -R pythian:pythian /opt/code/
sudo chmod 750 /opt/code/
}



echo "****Started Provisioning*****\n"
sudo apt-get update >/dev/null 2>&1
mysql_prov
github_prov
apache_prov
check_installation
prepare_directory_and_clone_git