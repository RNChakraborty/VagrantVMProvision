 #!/bin/bash
 
is_vagrant_up=`vagrant status | awk '/virtualbox/{$1="";print $0}'| awk '{$1=$1}1'`

if [[ "$is_vagrant_up" = "running (virtualbox)"  ]]; then
  echo "Vagrant is already running!!! Operation is aborted. Run vagrant destroy  and try again."
  exit
fi

if [ -f log.txt ]; then
    rm -rf log.txt
fi
 
echo "Enable Github install while provisioning ? Type 1 or 2 " 
select yn in "Yes" "No"; do
  case $yn in
   	  Yes )  sed -i "s/^\(provision_git='\).*/\1true'/" provisioning_scripts/prov.sh; break;;
	   No )  sed -i "s/^\(provision_git='\).*/\1false'/" provisioning_scripts/prov.sh; break;;
  esac
 done 
 echo "Enable MySql install while provisioning ? ? Type 1 or 2 " 
select yn in "Yes" "No"; do
  case $yn in
       Yes )  sed -i "s/^\(provision_mysql='\).*/\1true'/" provisioning_scripts/prov.sh; break;;
	   No )  sed -i "s/^\(provision_mysql='\).*/\1false'/" provisioning_scripts/prov.sh; break;;
  esac
 done 
echo "Enable Apache install while provisioning ? ? Type 1 or 2" 
select yn in "Yes" "No"; do
  case $yn in
      Yes )  sed -i "s/^\(provision_apache='\).*/\1true'/" provisioning_scripts/prov.sh; break;;
	   No )  sed -i "s/^\(provision_apache='\).*/\1false'/" provisioning_scripts/prov.sh; break;;
  esac
 done  
 echo "Wait while VM and the selected applications are being provisioned!!!"
 echo "To see the log, use <tail -f log.txt>"
 vagrant up >> log.txt 2>&1
 cat log.txt | awk '/appout:/{$1=$2=$3="";print $0}'

