#!/bin/bash

VBoxManage controlvm pbureeraS poweroff
VBoxManage unregistervm pbureeraS --delete

vagrant destroy -f

rm -rf ../.vagrant

VBoxManage list vms
