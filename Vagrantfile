# -*- mode: ruby -*-
# vi: set ft=ruby :

# Specify default Vagrant provider
VAGRANT_DEFAULT_PROVIDER = "virtualbox"

# Specify minimum Vagrant version and Vagrant API version
Vagrant.require_version ">= 1.8.0"
VAGRANTFILE_API_VERSION = "2"

# Require YAML module
require 'yaml'

# Read YAML file with box details
servers = YAML.load_file('servers.yaml')

Vagrant.configure('2') do |config|
  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true

  # http proxy setting to allow package installation
  # config.proxy.http           = ENV['http_proxy']
  # config.proxy.https          = ENV['http_proxy']
  # config.proxy.no_proxy       = ENV['no_proxy']

  # disable ssh key insert to allow packaged box file to login
  config.ssh.insert_key       = false
  config.ssh.forward_agent    = true

  config.vm.synced_folder ".", "/vagrant", type: "virtualbox"

  # disable box update checks to speed up the start up time
  config.vm.box_check_update  = false

  # Iterate through entries in YAML file
  servers.each do |server|
    config.vm.define server["name"] do |srv|
      # use local box file
      srv.vm.box = server["box"]
      srv.vm.hostname = server["name"]
      # config local network
      srv.vm.network "private_network", ip: server["ip"]
      srv.vm.provision "shell", path: server["shell_path"]
      srv.vm.provider :virtualbox do |vb|
        vb.name = server["name"]
        vb.memory = server["ram"]
        vb.cpus = server["cpus"]
      end
    end
  end
end