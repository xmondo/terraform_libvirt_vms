# Terraform Libvirt VMs

Terraform configuration file to deploy one or more KVM guests with an Ansible user for post-deployment configuration tasks. 

# Preliminaries

1. Edit <b><i>main.tf</b></i> and update the <b><i>hostname</b></i> array. 

Additonal <b><i>main.tf</b></i> variables include: 

- domain { default = "local" }
- memoryMB { default = 1024 * 2 }
- cpu { default = 2 }

2. Edit <b><i>cloud_init.cfg</b></i> and update the Ansible user name, user name group, password hash and ssh authorization key. Update the root login password (if any).

3. 
