terraform {
  required_version = ">= 0.12"
  required_providers {
    libvirt = {
      source = "dmacvicar/libvirt"
    }
  }
}

# variables
variable "hostname" {
  type    = list(string)
  default = ["dev1","dev2"]
}
variable "domain" { default = "local" }
variable "memoryMB" { default = 1024 * 2 }
variable "cpu" { default = 2 }

# terraform provider
provider "libvirt" {
  uri = "qemu:///system"
}

# volume
resource "libvirt_volume" "os_image" {
  count  = length(var.hostname)
  name   = "os_image.${var.hostname[count.index]}"
  pool   = "default"
  source = "/export/qcow2/bionic-amd64.qcow2"
  format = "qcow2"
}

# cloudinit disk
resource "libvirt_cloudinit_disk" "commoninit" {
  count          = length(var.hostname)
  name           = "${var.hostname[count.index]}-commoninit.iso"
  pool           = "default"
  user_data      = data.template_file.user_data[count.index].rendered
  network_config = data.template_file.network_config.rendered
}

data "template_file" "user_data" {
  count    = length(var.hostname)
  template = file("${path.module}/cloud_init.cfg")
  vars = {
    hostname = element(var.hostname, count.index)
    fqdn     = "${var.hostname[count.index]}.${var.domain}"
  }
}

data "template_file" "network_config" {
  template = file("${path.module}/network_config.cfg")
}

# guests 
resource "libvirt_domain" "domain-ubuntu" {
  count  = length(var.hostname)
  name   = var.hostname[count.index]
  memory = var.memoryMB
  vcpu   = var.cpu
  disk {
    volume_id = element(libvirt_volume.os_image.*.id, count.index)
  }
  network_interface {
    network_name = "bridge_br0"
  }
  cloudinit = libvirt_cloudinit_disk.commoninit[count.index].id
  console {
    type        = "pty"
    target_port = "0"
    target_type = "serial"
  }
  graphics {
    type        = "spice"
    listen_type = "address"
    autoport    = "true"
  }
}

output "ips" {
  value = libvirt_domain.domain-ubuntu.*.network_interface.0.addresses
}
