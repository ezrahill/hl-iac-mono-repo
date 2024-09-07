locals {
  nic_last_octet = 26
  vmid           = 700
  vm_name        = "test-vm"
  vm_count       = 1
  # nic_mac_prefix = "00:1a:4a:21"
  # nic_mac        = "00:1a:4a:21:00:1a"
  vm_tags = "core,debian"
}