# Required configuration

variable "cluster_name" {}

#
# Server nodes that will be part of the Kubernetes cluster
#
variable "servers" {
  type = map(
    object({
      # Name of the node
      name               = string,
      # The private address of the node
      private_ip_address = string,
      # Hetzner server type
      server_type        = string,
      # Hetzner base OS image
      image              = string,
      # Datacenter location
      location           = string,
      # Whether backups are needed for it
      backups            = bool,
      # Cloud-Init script reference (see user_data_scripts map)
      user_data_script   = string,
      # Rancher/K8s node roles (e.g.: "--worker --etcd --controlplane)
      roles              = string
    })
  )
}

variable "ssh_private_key" {}
variable "ssh_public_key" {}
variable "ansible_playbook_path" {}
variable "ansible_vault_password_path" {}

#
# The rancher node command to be executed
#
variable "rancher_node_command" {
  default = ""
}

#
# Whether to execute RKE deployment on the node at all
#
variable "run_rancher_deploy" {
  default = true
}

# Optional configuration

variable "hcloud_location" {
  default = "nbg1"
}
variable "private_ip_range" {
  default = "10.0.0.0/16"
}
variable "ssh_public_key_name" {
  default = "default"
}
variable "private_network_name" {
  default = "default"
}
variable "private_network_zone" {
  default = "eu-central"
}
variable "floating_ip_name" {
  default = "default"
}
variable "install_ansible_dependencies" {
  default = true
}
variable "ansible_dependencies_install_command" {
  default = "sudo yum install -y python36"
}
variable "run_ansible_playbook" {
  default = true
}
variable "post_ansible_ssh_user" {
  default = "deploy"
}

#
# Map of user-data scripts that can be referenced from the servers
#
# The key is the name of the script (e.g.: centos7-generic), the value
# is the Cloud-Init script, in one of the accepted format (YAML recommended)
#
# These scripts can be used for repartitioning the disks...etc other
# VM-init-time configuration (for details, see Cloud-Init)
#
variable "user_data_scripts" {
  type = map(string)
  default = {}
}
