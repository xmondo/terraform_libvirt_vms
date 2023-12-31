# Terraform Libvirt VMs

Terraform configuration file to deploy one or more KVM guests with an Ansible user for post-deployment configuration tasks. 

## Preliminaries

### 1. main.tf 

Edit <b><i>main.tf</b></i> and update the <b><i>hostname</b></i> array. 

Additonal <b><i>main.tf</b></i> variables include: 

- domain { default = "local" }
- memoryMB { default = 1024 * 2 }
- cpu { default = 2 }
- resource "libvirt_volume" `<volume name>` source = `<path to qcow2 cloudinit image>`
- resource "libvirt_domain" network_interface network_name = `<kvm network>`

### 2. cloud_init.cfg

Edit <b><i>cloud_init.cfg</b></i> and update the Ansible user name, user name group, hashed password and ssh authorization key. Update the root login password (if any). The following is an option to generate the Ansible user hashed password:

`mkpasswd -m SHA-512|SHA-256|md5 -s` 

Enter the password (stdin) when prompted. 

### 3. network_config.cfg 

The default configuration uses the guest OS ethernet naming convention and is set to dhcp4.

## Usage

`terraform init`

`terraform fmt`

`terraform validate`

`terraform plan -out=<execution plan name>`

`terraform apply <execution plan name>`



