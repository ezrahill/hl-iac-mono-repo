variable "pm_host" {
  description = "Proxmox Hostname"
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
