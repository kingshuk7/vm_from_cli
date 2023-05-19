#!/bin/sh
echo "Current VM status:"
echo
/usr/bin/virsh list --all

process=$(virsh list --all | grep -v "Id" | grep -v "-" | awk '{print $3}')

if [ "$process" ]; then
	virsh net-dhcp-leases default
	echo
	echo "Do you want to log in to a running VM or shutdown a running VM?"
       	read -p "Type 'yes' to log in, 'no' to skip logging in or 'stop' to shutdown VM: " login_choice
	echo
	if [ "$login_choice" = 'yes' ]; then
		read -p "Enter your username: " usr
		read -p "Enter the IP: " ip
		/usr/bin/ssh "$usr"@"$ip"
	elif [ "$login_choice" = 'no' ]; then
		echo "VM is running and ready to login."
	elif [ "$login_choice" = 'stop' ]; then
		read -p "Enter the name of the VM you want to shutdown: " vm_stop
		/usr/bin/virsh shutdown "$vm_stop"
	fi
else
	echo "Do you want to start any VM?" 
	read -p "Type 'start' to start the VM or 'no action' for no action: " choice
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
	elif [ "$choice" = 'no action' ]; then
		echo "This script is for starting/stoping VM from CLI."
		echo
		echo "Run the sctipt as given below"
		echo 
		echo ". ~/start_stop_login_vm.sh"
		echo
	else
		echo
		echo "Wrong input!!"
	fi
fi
