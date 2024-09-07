locals {
  nic_last_octet = 31
  vmid           = 3330
  vm_name        = "k3s-devnode"
  vm_count       = 5
  nic_mac_prefix = "52:54:33:33"
  vm_tags        = "k3s,dev"
  vm_cpu_cores   = 4
  vm_memory      = 16384
  additional_disks = [
    {
      storage = "internal_zpool_rZ"
      size    = "25G"
      discard = true
      cache   = "writeback"
    }
  ]
}