#!/bin/bash

set -x

# Ensure password authentication is turned on
sudo sed -i "s/^PasswordAuthentication no/PasswordAuthentication yes/g" /etc/ssh/sshd_config

# Let's bring things up to date
#sudo rpm -iUvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
#sudo yum update -y && sudo yum install -y net-tools wget ansible python-docker-py
sudo yum install -y epel-release
sudo yum update -y && sudo yum install -y net-tools wget ansible python-docker-py python-prettytable

# Ansible config tuning
ansible_home="\/vagrant\/Ansible"

## turn off fact gathering
sudo sed -i "s/^#gathering = implicit/gathering = explicit/g" /etc/ansible/ansible.cfg

## Set default hosts
sudo sed -i "s/^#inventory      = \/etc\/ansible\/hosts/inventory = ${ansible_home}\/hosts/g" /etc/ansible/ansible.cfg

## Set default roles
sudo sed -i "s/^[#]*roles_path .*/roles_path = ${ansible_home}\/playbooks\/roles:${ansible_home}\/playbooks\/roles\/common:${ansible_home}\/playbooks\/roles\/app/g" /etc/ansible/ansible.cfg

## Turn off ssh host key checking
sudo sed -i "s/^#host_key_checking = False/host_key_checking = False/g" /etc/ansible/ansible.cfg

## Turn off host key recording
sudo sed -i "s/^#record_host_keys=False/record_host_keys=False/g" /etc/ansible/ansible.cfg

## Set callback white list
sudo sed -i "s/^#callback_whitelist = timer, mail/callback_whitelist=custom_slack/g" /etc/ansible/ansible.cfg

## Turn off SELunix
sudo sed -i "s/^SELINUX=enforcing/SELINUX=permissive/g" /etc/sysconfig/selinux