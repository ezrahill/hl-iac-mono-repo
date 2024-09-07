// Create DevBox VM

module "ai-host" {
  source         = "../../modules/pve-vm"
  nic_last_octet = local.nic_last_octet
  vmid           = local.vmid
  vm_name        = local.vm_name
  vm_count       = local.vm_count
  vm_cpu_cores   = local.vm_cpu_cores
  vm_cpu_sockets = local.vm_cpu_sockets
  vm_memory      = local.vm_memory
  vm_tags        = local.vm_tags

  # Global Variables
  ssh_key        = var.ssh_key
  network_prefix = var.network_prefix
  pm_host        = var.pm_host
}
