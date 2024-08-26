// Create DevBox VM

module "k3s-cluster" {
  source         = "../../modules/pve-vm"
  nic_last_octet = local.nic_last_octet
  vmid           = local.vmid
  vm_name        = local.vm_name
  vm_count       = local.vm_count
  vm_tags        = local.vm_tags

  # Use either the nic_mac or nic_mac_prefix to generate the MAC address or none to use the default
  nic_mac_prefix = local.nic_mac_prefix       # ONLY USE IF YOU ARE CREATING MULTIPLE VMs
  # nic_mac = local.nic_mac        # ONYLY USE IF YOU AER CREATING A SINGLE VM

  # Global Variables
  ssh_key        = var.ssh_key
  network_prefix = var.network_prefix
  pm_host        = var.pm_host
}
