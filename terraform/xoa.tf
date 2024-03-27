variable "xoa-pool"{
  type = string
  description = "Xen Orchestra - Pool Name"
}
variable "xoa-template"{
  type = string
  description = "Xen Orchestra - Template Name"
}
variable "xoa-sr"{
  type = string
  description = "Xen Orchestra - Storage Repository Name"
}
variable "xoa-network"{
  type = string
  description = "Xen Orchestra - Network Name"
}

# Pool definition
data "xenorchestra_pool" "main"{
  name_label = var.xoa-pool
}

# Template definition
data "xenorchestra_template" "deb12_cloud" {
  name_label = var.xoa-template
}

# Storage Repository definition
data "xenorchestra_sr" "zfs-main" {
  name_label = var.xoa-sr
  pool_id = data.xenorchestra_pool.main.id
}

# Network definition
data "xenorchestra_network" "vlan1017" {
  name_label = var.xoa-network
  pool_id = data.xenorchestra_pool.main.id
}

