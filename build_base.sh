#!/bin/bash
echo "Exporting required variables ..."
#export http_proxy=
#export https_proxy=
#export no_proxy=localhost,127.0.0.1

echo "Installing Vagrant dependencies ..."
vagrant plugin install vagrant-env
vagrant plugin install vagrant-proxyconf
vagrant plugin install vagrant-share
vagrant plugin install vagrant-vbguest
vagrant plugin install vagrant-hostmanager

echo "making Boxes dir ..."
mkdir Boxes

echo "making sure base vm is down ..."
vagrant destroy -f base

echo "starting base vm ..."
vagrant up base

echo "starting cleaning up old box file ..."
rm -f Boxes/centos7.box
vagrant box remove --force  file://Boxes/centos7.box

echo "packing the new image into Boxes/centos7.box"
vagrant package --base base -o Boxes/centos7.box

echo "cleaning up base vm ..."
vagrant destroy -f base
