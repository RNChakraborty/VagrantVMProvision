 #!/bin/bash
 
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
 
 
 vagrant up 

