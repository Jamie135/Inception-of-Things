#!/bin/bash

VBoxManage controlvm pbureeraS poweroff
VBoxManage unregistervm pbureeraS --delete
VBoxManage controlvm pbureeraSW poweroff
VBoxManage unregistervm pbureeraSW --delete

vagrant destroy -f

VBoxManage list vms
