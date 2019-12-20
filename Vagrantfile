# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = '2'

VAGRANT_COMMAND = ARGV[0]

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  
  config.vm.define 'devops-box' do |devbox|
    # Make sure to have installed vagrant-env plugin
    devbox.env.enable
    
    # basebox
    devbox.vm.box = ENV['OS_VERSION']

    #hostname
    devbox.vm.hostname = ENV['HOSTNAME']
    
    # Make sure to have installed vagrant-disksize plugin
    devbox.disksize.size = ENV['DISK_SIZE']

    #mount project
    #devbox.vm.synced_folder ENV['XXX'], "/home/vagrant/workspace"

    #mount ssh keys and .gitconfig into /tmp directory and through permission script move them later
    devbox.vm.synced_folder "~/.ssh/", "/tmp/.ssh/", create:true
    devbox.vm.synced_folder "~/.aws/", "/tmp/.aws/", create:true
    devbox.vm.provision "file", source: "~/.gitconfig", destination: "/tmp/"
    devbox.vm.provision "file", source: ".env", destination: "/tmp/"

    #bootstrap
    devbox.vm.provision "shell", path: "scripts/bootstrap.sh"

    #file permission
    devbox.vm.provision "shell", path: "scripts/permission.sh"

    devbox.vm.provider "virtualbox" do |v|
      v.name = ENV['VM_NAME']
      v.memory = ENV['MEMORY']
      v.cpus = ENV['NO_CPUS']
    end
  end
end