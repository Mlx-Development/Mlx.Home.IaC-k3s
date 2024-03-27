variable "k3s-ansb-sshkey" {
  type = string
  description = "Ansible - Local SSH Key to use for Ansible"
}

variable "k3s-ansb-hostslocation" {
  type = string
  description = "Ansible - Location of hosts.ini file for Ansible"
}

# Reads the public key for the key to be used in Ansible
data "local_file" "k3s-ansb-sshkey_pub" {
    filename = "${var.k3s-ansb-sshkey}.pub"
}

# generates template for hosts.ini for Ansible
# with each host having a dedicated private ssh key
# that matches the public key above
data "template_file" "k3s-config"{
  template = file("./ansible-templates/k3s-ansb.tftpl")
  vars = {
    k3s_master_ip = "${join("\n", [for instance in xenorchestra_vm.k3s-srvr : join("", [instance.ipv4_addresses[0], " ansible_ssh_private_key_file=", var.k3s-ansb-sshkey])])}"
    k3s_node_ip   = "${join("\n", [for instance in xenorchestra_vm.k3s-wrkr : join("", [instance.ipv4_addresses[0], " ansible_ssh_private_key_file=", var.k3s-ansb-sshkey])])}"
  }
}

# Actually creates the hosts.ini file form the template
resource "local_file" "k3s-config-file" {
  content  = data.template_file.k3s-config.rendered
  filename = var.k3s-ansb-hostslocation
  file_permission = "0640"
}

# Some output data for easier viewing in the tfstate for IP addresses
output "Master-IPS" {
  value = ["${xenorchestra_vm.k3s-srvr.*.ipv4_addresses}"]
}
output "worker-IPS" {
  value = ["${xenorchestra_vm.k3s-wrkr.*.ipv4_addresses}"]
}
