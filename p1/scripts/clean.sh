#!/bin/bash

# rm -rf /home/pbureera/VirtualBox\ VMs/pbureeraS
# rm -rf /home/pbureera/VirtualBox\ VMs/pbureeraSW

VBoxManage controlvm pbureeraS poweroff
VBoxManage unregistervm pbureeraS --delete
VBoxManage controlvm pbureeraSW poweroff
VBoxManage unregistervm pbureeraSW --delete

vagrant destroy -f

rm -rf ../.vagrant

VBoxManage list vms
