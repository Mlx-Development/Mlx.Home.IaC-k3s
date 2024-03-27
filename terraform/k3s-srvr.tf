variable "k3s-srvr-macs"{
  type = list(string)
  description = "k3s - Server Nodes - Mac Addresses / Count"
}

variable "k3s-srvr-memory"{
  type = number
  description = "k3s - Server Nodes - Amount of GiB of memory"
}

variable "k3s-srvr-cores"{
  type = number
  description = "k3s - Server Nodes - Number of cores"
}

variable "k3s-srvr-storage"{
  type = number
  description = "k3s - Server Nodes - Amount of GiB of storage"
}

variable "k3s-srvr-basedescription"{
  type = string
  description = "k3s - Server Nodes - Base Description Text"
}

variable "k3s-srvr-namelabel"{
  type = string
  description = "k3s - Server Nodes - Name Label"
}

variable "k3s-srvr-tags"{
  type = list(string)
  description = "k3s - Server Nodes - Tags"
}

variable "k3s-srvr-basehostname"{
  type = string
  description = "k3s - Server Nodes - Base Host Name"
}

variable "k3s-srvr-disklabel"{
  type = string
  description = "k3s - Server Nodes - Base Disk Label"
}

# VM resource for "Server Nodes"
resource "xenorchestra_vm" "k3s-srvr" {
  count = length(var.k3s-srvr-macs)
  auto_poweron = true
  name_description = "${var.k3s-srvr-basedescription} | ${count.index}"
  tags = var.k3s-srvr-tags
  memory_max = var.k3s-srvr-memory*1073741823
  cpus = var.k3s-srvr-cores
  name_label = "${var.k3s-srvr-namelabel} ${count.index}"
  wait_for_ip = true
  template = data.xenorchestra_template.deb12_cloud.id
  cloud_config = templatefile("cloud-init-templates/config_ansible.tftpl", {
    hostname = "${var.k3s-srvr-basehostname}-${count.index}"
    username = var.linux-username
    ssh-keys = var.linux-sshkeys
    ansible-ssh-key = data.local_file.k3s-ansb-sshkey_pub.content
  })
  cloud_network_config = templatefile("cloud-init-templates/network_dhcp.tftpl",{
    mac = element(var.k3s-srvr-macs, count.index)
  })

  network {
    network_id = data.xenorchestra_network.vlan1017.id
    mac_address = element(var.k3s-srvr-macs, count.index)
  }

  disk {
    sr_id = data.xenorchestra_sr.zfs-main.id
    name_label = "${var.k3s-srvr-disklabel} ${count.index}"
    size = var.k3s-srvr-storage*1073741823
  }
}

