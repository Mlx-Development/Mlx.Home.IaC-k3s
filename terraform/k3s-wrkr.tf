variable "k3s-wrkr-macs"{
  type = list(string)
  description = "k3s - Worker Nodes - Mac Addresses / Count"
}

variable "k3s-wrkr-memory"{
  type = number
  description = "k3s - Worker Nodes - Amount of GiB of memory"
}

variable "k3s-wrkr-cores"{
  type = number
  description = "k3s - Worker Nodes - Number of cores"
}

variable "k3s-wrkr-storage"{
  type = number
  description = "k3s - Worker Nodes - Amount of GiB of storage"
}

variable "k3s-wrkr-basedescription"{
  type = string
  description = "k3s - Worker Nodes - Base Description Text"
}

variable "k3s-wrkr-namelabel"{
  type = string
  description = "k3s - Worker Nodes - Name Label"
}

variable "k3s-wrkr-tags"{
  type = list(string)
  description = "k3s - Worker Nodes - Tags"
}

variable "k3s-wrkr-basehostname"{
  type = string
  description = "k3s - Worker Nodes - Base Host Name"
}

variable "k3s-wrkr-disklabel"{
  type = string
  description = "k3s - Worker Nodes - Base Disk Label"
}

# VM resource for "Worker Nodes"
resource "xenorchestra_vm" "k3s-wrkr" {
  count = length(var.k3s-wrkr-macs)
  auto_poweron = true
  name_description = "${var.k3s-wrkr-basedescription} | ${count.index}"
  tags = var.k3s-wrkr-tags
  memory_max = var.k3s-wrkr-memory*1073741823
  cpus = var.k3s-wrkr-cores
  name_label = "${var.k3s-wrkr-namelabel} ${count.index}"
  wait_for_ip = true
  template = data.xenorchestra_template.deb12_cloud.id
  cloud_config = templatefile("cloud-init-templates/config_ansible.tftpl", {
    hostname = "${var.k3s-wrkr-basehostname}-${count.index}"
    username = var.linux-username
    ssh-keys = var.linux-sshkeys
    ansible-ssh-key = data.local_file.k3s-ansb-sshkey_pub.content
  })
  cloud_network_config = templatefile("cloud-init-templates/network_dhcp.tftpl",{
    mac = element(var.k3s-wrkr-macs, count.index)
  })

  network {
    network_id = data.xenorchestra_network.vlan1017.id
    mac_address = element(var.k3s-wrkr-macs, count.index)
  }

  disk {
    sr_id = data.xenorchestra_sr.zfs-main.id
    name_label = "${var.k3s-wrkr-disklabel} ${count.index}"
    size = var.k3s-wrkr-storage*1073741823
  }
}

