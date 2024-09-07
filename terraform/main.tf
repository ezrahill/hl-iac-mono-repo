module "test-vm" {
  source = "./deployments/test-vm"

  providers = {
    proxmox = proxmox
  }
  network_prefix = var.network_prefix
  pm_host        = var.pm_host
  ssh_key        = var.ssh_key
}

module "k3s-cluster" {
  source = "./deployments/k3s-cluster"

  providers = {
    proxmox = proxmox
  }
  network_prefix = var.network_prefix
  pm_host        = var.pm_host
  ssh_key        = var.ssh_key
}

module "ai-host" {
  source = "./deployments/ai-host"

  providers = {
    proxmox = proxmox
  }
  network_prefix = var.network_prefix
  pm_host        = var.pm_host
  ssh_key        = var.ssh_key
}