#!/bin/sh
echo "Current VM status:"
echo
/usr/bin/virsh list --all

echo
echo "Do you want to start or stop a VM?"
echo
read -p "Type 'start' to start the VM or 'stop' for shutting down a running VM: " choice
echo
if [ "$choice" = 'start' ]; then
	read -p "Enter name of the VM you want to start: " vm_start
	/usr/bin/virsh start "$vm_start"
	echo
	echo "VM is getting ready for login..."
	sleep 5
	echo
	virsh net-dhcp-leases default
	echo
	echo "Do you want to login?" 
	read -p "Type 'yes' to log in, 'no' skip logging in: " login
	echo
	if [ "$login" = 'yes' ]; then
		read -p "Enter your username: " usr
		read -p "Enter the IP: " ip
		/usr/bin/ssh "$usr"@"$ip"
		echo
	elif [ "$login" = 'no' ]; then
		echo "VM is ready to log in."
	fi
elif [ "$choice" = 'stop' ]; then
	read -p "Enter the name of the VM you want to shutdown: " vm_stop
	/usr/bin/virsh shutdown "$vm_stop"
else
	echo "This script is for starting/stoping VM from CLI."
	echo
	echo "Run the sctipt as given below"
	echo 
	echo ". ~/start_stop_vm.sh"
	echo
else
	echo
	echo "Wrong input!!"
fi
