
Vagrant.configure("2") do |config|
  config.vm.box = "hashicorp/precise64"
  config.vm.network :forwarded_port, guest: 3306, host: 3308
  config.vm.provision :shell, :path => "scripts/prov.sh"
end