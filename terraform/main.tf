module "test-vm" {
  source = "./deployments/test-vm"

  providers = {
    proxmox = proxmox
  }
  network_prefix = var.network_prefix
  pm_host        = var.pm_host
  ssh_key        = var.ssh_key
}