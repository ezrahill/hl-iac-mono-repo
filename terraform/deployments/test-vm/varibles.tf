# variable "pm_ip" {
#   description = "IP of Proxmox server"
#   type        = string
# }

# variable "pm_user" {
#   description = "Proxmox User"
#   type        = string
# }

# variable "pm_password" {
#   description = "Password for user"
#   type        = string
# }

variable "pm_host" {
  description = "Proxmox Hostname"
  type        = string
}

# variable "vm_name" {
#   description = "Name of the VM"
#   type        = string
# }

variable "network_prefix" {
  description = "Network prefix for the runner IP address - e.g. 192.168.1"
  type        = string
}

# variable "mac_address" {
#   description = "MAC address for the runner"
#   type        = string
# }

variable "ssh_key" {
  description = "SSH key for the runner"
  type        = string
  sensitive   = true
}

# variable "nic_last_octet" {
#   description = "Last octet of the VM IP address"
#   type        = number
# }

# variable "vmid" {
#   description = "VM ID"
#   type        = number
# }

# variable "nic_mac" {
#   description = "MAC address for the VM"
#   type        = string
# }