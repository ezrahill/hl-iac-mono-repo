locals {
  check_single_vm             = var.vm_count == 1
  vm_names                    = [for i in range(var.vm_count) : format("${var.vm_name}-%02d", i + 1)]
  nic_macs                    = [for i in range(var.vm_count) : format("${var.nic_mac_prefix}:%02d:%02d", floor(i / 100), i % 100)]
  check_single_key_with_value = local.nic_macs[0] == ":00:00"
  network_configs             = [for i in range(var.vm_count) : "ip=${var.network_prefix}.${i + var.nic_last_octet}/24,gw=${var.network_prefix}.1"]
}