variable "proxmox_ip" {
  description = "IP address of the Proxmox server"
  type        = string
}

variable "proxmox_user" {
  description = "Proxmox username"
  type        = string
}

variable "proxmox_password" {
  description = "Proxmox password"
  type        = string
  sensitive   = true
}

variable "proxmox_node" {
  description = "Proxmox node to deploy the VM"
  type        = string
}

variable "iso_file" {
  description = "Name of the ISO file"
  type        = string
}

variable "iso_checksum" {
  description = "Checksum of the ISO file"
  type        = string
}

variable "iso_version" {
  description = "ISO version (e.g., 12 for Debian 12)"
  type        = string
}

variable "vm_id" {
  description = "VM ID to assign"
  type        = number
}

variable "ssh_username" {
  description = "SSH username for the VM"
  type        = string
}

variable "ssh_password" {
  description = "SSH password for the VM"
  type        = string
  sensitive   = true
}

variable "memory" {
  description = "Memory allocation for the VM in MB"
  type        = number
  default     = 2048
}

variable "cores" {
  description = "Number of CPU cores for the VM"
  type        = number
  default     = 2
}

variable "sockets" {
  description = "Number of CPU sockets for the VM"
  type        = number
  default     = 1
}

variable "disk_size" {
  description = "Disk size for the VM in GB"
  type        = string
  default     = "5G"
}