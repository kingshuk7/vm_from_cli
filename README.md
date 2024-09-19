# Shell Scripts to Create and Start, Stop or Login to a Running VM from CLI
These scripts create and start VM. The `create_vm.sh` script asks for user inputs and based on the inputs it creates the VM and `start_stop_vm` asks for user inputs and based on the inputs it starts or stops a VM and `login_vm.sh` to login to a running VM.
 
## Clone the repository
Clone the repository and use the `create_vm.sh` to create the VM and `start_stop_vm.sh` to start or stop a VM and `login_vm.sh` login to a running VM.
```bash
cd ~/
git clone https://github.com/kingshuk7/vm_from_cli.git
cd vm_from_cli
sh create_vm.sh
sh start_stop_vm.sh
sh login_vm.sh
```

# NB
* You might need to change some parameters in the `create_vm.sh` as the script is tested with Ubuntu and FreeBSD ISOs only.
