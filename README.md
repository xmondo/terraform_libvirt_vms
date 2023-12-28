# Terraform Libvirt VMs

Terraform configuration file to deploy one or more KVM guests with an Ansible user for post-deployment configuration tasks. 

# Preliminaries

## 1. main.tf 

Edit <b><i>main.tf</b></i> and update the <b><i>hostname</b></i> array. 

Additonal <b><i>main.tf</b></i> variables include: 

- domain { default = "local" }
- memoryMB { default = 1024 * 2 }
- cpu { default = 2 }

## 2. cloud_init.cfg

Edit <b><i>cloud_init.cfg</b></i> and update the Ansible user name, user name group, hashed password and ssh authorization key. Update the root login password (if any). The following is an option to generate the Ansible user hashed password:

`mkpasswd -m SHA-512|SHA-256|md5 -s` 

Type the password (to stdin) when prompted. 



4. 
