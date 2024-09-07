provider "proxmox" {
  pm_api_url = "https://${var.pm_ip}:8006/api2/json"
  pm_debug   = true
  pm_log_levels = {
    _default    = "debug"
    _capturelog = ""
  }
  pm_parallel     = 3
  pm_password     = var.pm_password
  pm_tls_insecure = true
  pm_user         = var.pm_user
}
