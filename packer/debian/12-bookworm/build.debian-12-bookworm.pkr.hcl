build {
  sources = ["source.proxmox-iso.debian-cloud-init"]

  provisioner "shell" {
    inline = [
      "echo 'Installing Cloud-init...'",
      "export DEBIAN_FRONTEND=noninteractive",
      "apt-get update",
      "apt-get install -y qemu-guest-agent screenfetch inxi vim htop parted curl",
      "systemctl start qemu-guest-agent",
      "apt-get install -y cloud-init",
      "cloud-init clean",
    ]
  }

  provisioner "file" {
    source      = "http/00-banner"
    destination = "/etc/update-motd.d/00-banner"
  }

  provisioner "file" {
    source      = "http/01-custom"
    destination = "/etc/update-motd.d/01-custom"
  }

  provisioner "file" {
    source      = "http/resize-lvm-cloud-init"
    destination = "/usr/bin/resize-lvm-cloud-init"
  }

  provisioner "file" {
    source      = "http/cloud.cfg"
    destination = "/etc/cloud/cloud.cfg"
  }

  provisioner "file" {
    source      = "http/99-pve.cfg"
    destination = "/etc/cloud/cloud.cfg.d/99-pve.cfg"
  }

  provisioner "shell" {
    inline = [
      "echo 'Finalizing the setup...'",
      "cloud-init clean",
    ]
  }
}
