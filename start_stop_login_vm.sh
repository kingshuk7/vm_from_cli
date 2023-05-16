#!/bin/sh
echo "Current VM status:"
echo
/usr/bin/virsh list --all

process=$(virsh list --all | grep -v "Id" | grep -v "-" | awk '{print $3}')

if [ "$process" ]; then
	virsh net-dhcp-leases default
	echo
	read -p "Do you want to login? (type 'yes') " login_choice
	echo
	if [ "$login_choice" = 'yes' ]; then
		read -p "Enter your username: " usr
		read -p "Enter the IP: " ip
		/usr/bin/ssh "$usr"@"$ip"
	else
		echo "VM is running and ready to login."
	fi
else
	read -p "Do you want to start/stop any VM? (type 'start', 'stop' or 'no action'): " choice
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
		read -p "Do you want to login (type 'yes' to login): " login
		echo
		if [ "$login" = 'yes' ]; then
			read -p "Enter your username: " usr
			read -p "Enter the IP: " ip
			/usr/bin/ssh "$usr"@"$ip"
			echo
		else
			echo "VM is ready to log in."
		fi
	elif [ "$choice" = 'stop' ]; then
		read -p "Enter the name of the VM you want to stop: " vm_stop
		/usr/bin/virsh shutdown "$vm_stop"
	elif [ "$choice" = 'no action' ]; then
		echo "This script is for starting/stoping VM from CLI."
	else
		echo
		echo "Wrong input!! Please type 'start' or 'stop'."
	fi
fi
