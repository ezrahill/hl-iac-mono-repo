locals {
  nic_last_octet = 241
  vmid           = 241
  vm_name        = "ai-host"
  vm_count       = 1
  vm_cpu_cores   = 6
  vm_cpu_sockets = 2
  vm_memory      = 32768
  vm_tags        = "core,debian,ai"
}