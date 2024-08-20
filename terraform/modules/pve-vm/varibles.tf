variable "pm_host" {
  description = "Proxmox Hostname"
  type        = string
}

variable "vm_name" {
  description = "Name of the VM"
  type        = string
}

variable "network_prefix" {
  description = "Network prefix for the runner IP address - e.g. 192.168.1"
  type        = string
}

variable "ssh_key" {
  description = "SSH key for the runner"
  type        = string
  sensitive   = true
}

variable "nic_last_octet" {
  description = "Last octet of the VM IP address"
  type        = number
}

variable "vmid" {
  description = "VM ID"
  type        = number
}

variable "nic_mac" {
  description = "MAC address for the VM"
  type        = string
  default     = ""
}

variable "nic_mac_prefix" {
  description = "MAC address prefix for the VMs. Used when creating multiple VMs"
  type        = string
  default     = ""
}

variable "vm_count" {
  description = "Number of VMs to create"
  type        = number
  default     = 1
}

variable "vm_tags" {
  description = "Tags for the VM"
  type        = string
  default     = ""
}