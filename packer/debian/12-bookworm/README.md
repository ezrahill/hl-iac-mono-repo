# Debian 12 (Bookworm) Packer Template for Proxmox

This project automates the creation of a Debian 12 VM template on Proxmox VE using Packer and a Bash script.

## Requirements
- Proxmox VE 8.2.4+
- Packer 1.9.4+

## Setup and Execution

1. **Download the Debian 12 ISO**
   The script checks if the Debian 12 ISO (`debian-12.6.0-amd64-netinst.iso`) exists locally. If not, it downloads it from the official Debian site.

2. **Calculate ISO Checksum**
   The script calculates the SHA256 checksum of the downloaded ISO.

3. **Upload ISO to Proxmox**
   The script uploads the ISO to the Proxmox server if it's not already present.

4. **Delete Existing VM**
   If a VM with the specified ID (`VM_ID`) exists on Proxmox, it is stopped and deleted.

5. **Run Packer**
   Finally, Packer is executed with the ISO checksum, file name, version, and other necessary variables to create the VM template.

## How to Run

```bash
./build.sh
```
## Notes

- Modify PROXMOX_HOST and VM_ID variables as needed.
- Ensure that Packer and Proxmox are correctly configured.
- The script assumes SSH access to Proxmox as root.

## License

MIT