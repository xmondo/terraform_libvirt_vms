# Terraform Libvirt VMs

Terraform configuration file to deploy one or more KVM guests.

# Usage

Edit <b><i>main.tf</b></i> and update the <b><i>hostname</b></i> array. 

Additonal variables include: 

- domain { default = "local" }
- memoryMB { default = 1024 * 2 }
- cpu { default = 2 }


