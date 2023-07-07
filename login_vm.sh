#!/bin/sh
echo "Current VM status:"
echo
/usr/bin/virsh list --all

process=$(virsh list --all | grep -v "Id" | grep "running" |awk '{print $3}' | head -1 | tail -1)

if [ "$process" = 'running' ]; then
	virsh net-dhcp-leases default
	echo
	echo "Do you want to log in to a running VM?"
       	read -p "Type 'yes' to log in, 'no' to skip logging: " login_choice
	echo
	if [ "$login_choice" = 'yes' ]; then
		read -p "Enter your username: " usr
		read -p "Enter the IP: " ip
		/usr/bin/ssh "$usr"@"$ip"
	elif [ "$login_choice" = 'no' ]; then
		echo "VM is running and ready to login"
		echo
		echo "This script is for logging in to a running VM from CLI."
		echo
		echo "Run the sctipt as given below"
		echo 
		echo ". ~/login_vm.sh"
		echo
	fi
else
	echo "No VM running!!!"
fi
