variable "pm_ip" {
  description = "IP of Proxmox server"
  type        = string
}

variable "pm_user" {
  description = "Proxmox User"
  type        = string
}

variable "pm_password" {
  description = "Password for user"
  type        = string
}

variable "network_prefix" {
  description = "Network prefix for the runner IP address - e.g. 192.168.1"
  type        = string
}

variable "pm_host" {
  description = "Proxmox Hostname"
  type        = string
}

variable "ssh_key" {
  description = "SSH key for the runner"
  type        = string
  sensitive   = true
}