#!/bin/bash

provision_git='true'
provision_mysql='false'
provision_apache='true'
# Install MySql if already not installed
mysql_prov(){
msql=$( command -v mysql );
if [ -z "$msql" ]; then
  sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password pythian'
  sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password pythian'
  sudo apt-get install -y mysql-server >/dev/null 2>&1
  printf "Finished Installing Mysql!!!"
  touch dbcreate
fi
}

#Install github if already not installed
github_prov(){
githb=$( command -v git );
if [ -z "$githb" ]; then
  sudo apt-get install -y git >/dev/null 2>&1
  printf "Finished Installing Github!!!"
  touch gitcreate
fi
}
#Install apache if already not installed
apache_prov(){
apache=$( command -v apache2 );
if [ -z "$apache" ]; then
  sudo apt-get install -y apache2 >/dev/null 2>&1
  printf "Finished Installing Apache!!!"
  touch apachecreate
fi

}

#Test for installation of the required software. If successful, creates user and group. Manages permission 
#and clones the git repo
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
  printf "\n\n"
  echo "appout:	git..."$github_print
  echo "appout:	mysql..."$msql_print
  echo "appout:	apache..."$apache_print
 
 if [[ "$all_installation_complete" = "true" ]]; then
    # Clone git repo     
	prepare_directory_and_clone_git
 else
    echo "appout:	Github repository will not be cloned !!!!. All 3 of the applications need to be installed."
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

printf "****Started Provisioning*****\n"
sudo apt-get update >/dev/null 2>&1

 if [[ "$provision_mysql" = "true" ]]; then
 mysql_prov
fi 
 if [[ "$provision_git" = "true" ]]; then
 github_prov
fi
 if [[ "$provision_apache" = "true" ]]; then
 apache_prov
fi
check_installation