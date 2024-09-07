resource "proxmox_vm_qemu" "ths_vm" {
  for_each = { for idx, name in local.vm_names : idx => name }

  agent       = 1
  vmid        = var.vmid + each.key
  name        = local.check_single_vm ? var.vm_name : each.value
  target_node = var.pm_host

  clone      = "debian-12.6.0-template"
  full_clone = "true"
  os_type    = "cloud-init"

  cores   = var.vm_cpu_cores
  sockets = var.vm_cpu_sockets
  memory  = var.vm_memory

  bootdisk = "scsi0"
  scsihw   = "virtio-scsi-pci"

  disks {
    scsi {
      scsi0 {
        disk {
          storage    = "internal_zpool_rZ"
          size       = "40G"
          discard    = true
          emulatessd = true
        }
      }
    }
    ide {
      ide0 {
        cloudinit {
          storage = "internal_zpool_rZ"
        }
      }
    }
    dynamic "virtio" {
      for_each = var.additional_disks
      content {
        virtio0 {


          disk {
            storage = virtio.value.storage
            size    = virtio.value.size
            discard = virtio.value.discard
            cache   = virtio.value.cache
          }
        }
      }
    }
  }


  network {
    model   = "virtio"
    bridge  = "vmbr0"
    macaddr = local.check_single_key_with_value ? var.nic_mac : local.nic_macs[each.key]
  }

  desc = "Deployment of ${each.value} completed on ${timestamp()}"
  tags = var.vm_tags

  # Cloud-init configuration
  ipconfig0  = local.network_configs[each.key]
  nameserver = "${var.network_prefix}.88"
  sshkeys    = var.ssh_key

  lifecycle {
    ignore_changes = [
      network.0.macaddr, # Ignore changes to macaddr
      sshkeys,           # Ignore changes to SSH keys
      network,           # Ignore changes to network attributes
      bootdisk,          # Ignore changes to bootdisk
      desc,              # Ignore changes to description
    ]
  }
}
