#!/bin/bash
set -x

# This seems to do the trick after vagrant set the private interface for the vm. otherwise the box does not take the private ip into consideration
sudo nmcli connection reload
sudo systemctl restart network.service
