#!/bin/bash

# echo "192.168.56.110 app1.com app2.com app3.com" | sudo tee -a /etc/hosts

# rm -rf /home/pbureera/VirtualBox\ VMs/pbureeraS

VBoxManage controlvm pbureeraS poweroff
VBoxManage unregistervm pbureeraS --delete

vagrant destroy -f

rm -rf ../.vagrant

VBoxManage list vms
