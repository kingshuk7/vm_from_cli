#!/bin/sh

echo "Warning!!! This script deletes an existing VM"
echo
echo "Current VM Status:"
/usr/bin/virsh list --all

echo
echo "Do you want to delete a VM?" 
echo
read -p "Type 'yes' to delete, else the script will be skipped from running: " user_choice
if [ "$user_choice" = 'yes' ]; then
	read -p "Enter the name of the VM you want to delete: " vm_del_only
	/usr/bin/virsh destroy "$vm_del_only"
	/usr/bin/virsh undefine "$vm_del_only" --remove-all-storage
else
	echo
	echo "No action taken!!"

fi
