#!/bin/sh
echo "Warning!!! This script deletes an existing VM"
echo
echo "Current VM Status:"
/usr/bin/virsh list --all

process=$(virsh list --all | grep -v "Id" | grep -v "-" | awk '{print $3}')

if [ "$process" ]; then
	virsh net-dhcp-leases default
	echo
	echo "Do you want shutdown and delete a running VM?"
	read -p "Type 'yes' to shutdown and delete, 'stop' to just shutdown VM, or 'no' for skipping the script from running: " user_choice
	echo
	if [ "$user_choice" = 'yes' ]; then
		read -p "Enter the name of the VM you want to shutdown and delete: " vm_del
		/usr/bin/virsh shutdown "$vm_del"
		echo
		echo "Waiting for the VM to shutdown..."
		sleep 5
		/usr/bin/virsh undefine "$vm_del" --remove-all-storage
	elif [ "$user_choice" = 'stop' ]; then
		read -p "Enter the name of the VM you want to shutdown: " vm_stop
		/usr/bin/virsh shutdown "$vm_stop"
	elif [ "$user_choice" = 'no' ]; then
                echo "No action taken!!"
	else
		echo "Wrong Input "		
        fi
else
	echo
	echo "Do you want to delete a VM?" 
	echo
	read -p "Type 'yes' to delete, else the script will be skipped from running: " user_choice2
	if [ "$user_choice2" = 'yes' ]; then
		read -p "Enter the name of the VM you want to delete: " vm_del_only
		/usr/bin/virsh undefine "$vm_del_only" --remove-all-storage
	else
		echo "No action taken!!"
	fi

fi
