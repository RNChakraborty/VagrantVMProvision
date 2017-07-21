#VagrantVMProvision
A Vagrant project (script) to automate a VM provision with APACHE, GITHUB and MYSQL.
bash scripting is used (Vagrant Shell Provisioner)  for provisioning. Oracle VirtualBox is used as box provider.

*** To Use***
Install Vagrant and Oracle Virtualbox 

After Successful Installation of Vagrant and Oracle Virtualbox , run try_vagrant.sh (bash try_vagrant.sh). This script has the option of conditional installation of Git, MySql and Apache.So users can chose to not install any (or all) of the 3 applications. This is finally reflected on the output produced

Example: if user chose to install only Github but not MySql or Apache, then final output will be 

  git... Installed     
  mysql... Not Installed!    
  apache... Installed     
  Github respository will not be cloned!!! All 3 of the applications need to be installed   

Thus, in order for the tool to clone the git repository, all 3 of the applications (git,mysql,apache) are required to be installed and should be selected when asked while running try_vagrant.sh script

**The try_vagrant.sh script will prompt you to run vagrant destroy if vagrant has already provisioned the VM and is already running **
