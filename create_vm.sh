#!/bin/sh
echo
echo "Creating virtual machine needs libvirt-*,bridge-utlis, virtins and virtmanager to be installed on the system."
echo
read -p "Do you want to proceed? (type 'yes' to proceed, 'no' to terminate the scripts) " choice
echo
if [ "$choice" = 'yes' ]; then
	
	sudo apt update -y
	sudo apt install libvirt-daemon-system libvirt-clients bridge-utils virtinst virt-manager -y
	
	mkdir -pv ~/kvm/disk; mkdir -pv ~/kvm/iso
	
	read -p "Enter your system username: " username
	echo
	
	sudo adduser "$username" libvirt; sudo adduser "$username" kvm;

	read -p "Do you want to download the ISO file (type 'yes' or 'no')? " iso_choice
	if [ "$iso_choice" = 'yes' ]; then
		read -p "Enter the link to the ISO file: " link
		/usr/bin/wget "$link" -P ~/kvm/iso
	fi
	echo
	read -p "Enter name of the VM: " name
	echo
	read -p "Enter OS Variant (i.e. 'ubuntu20.04', 'ubuntu22.04', etc.): " os
	echo
	read -p "Enter RAM size (1024 or 2048, 2048 is suggested): " ram
	echo
	read -p "Enter the full path to the ISO file with .iso extension: " iso
	echo
	read -p "Enter server image name: " img
	echo
	echo "Available networks"
       	virsh net-list --all
	read -p "Enter network name: " network
	echo
	virt-install --name "$name" \
		--os-variant "$os" \
		--ram "$ram" \
		--disk ~/kvm/disk/"$img"-01.img,device=disk,bus=virtio,size=10,format=qcow2 \
		--graphics vnc,listen=0.0.0.0 \
		--noautoconsole \
		--hvm \
		--vcpu=2 \
		--cdrom "$iso" \
		--boot cdrom,hd \
		--network network="$network"
else
	echo "Script terminatied!!"
fi
