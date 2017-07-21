
Vagrant.configure("2") do |config|
  config.vm.box = "hashicorp/precise64"
  config.vm.network :forwarded_port, guest: 80, host: 8081
  config.vm.network :forwarded_port, guest: 8080, host: 8082
  config.vm.network :forwarded_port, guest: 3306, host: 3308
  config.vm.provider "virtualbox" do |pvb|
    pvb.name = "pythian_box"
	pvb.memory = 1024
    pvb.cpus = 2
  end
  config.vm.provision :shell, :path => "scripts/prov.sh"
end