#!/bin/bash

# Set URLs and file names
ISO_FILE="debian-12.6.0-amd64-netinst.iso"
ISO_URL="https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/$ISO_FILE"
VERSION=$(echo "$ISO_FILE" | grep -oE '[0-9]+\.[0-9]+\.[0-9]+')
PROXMOX_HOST="192.168.21.105"
VM_ID="9110"

# Step 1: Download the QCOW2 file if it doesn't already exist
if [ ! -f "$ISO_FILE" ]; then
  echo "Downloading $ISO_FILE..."
  wget -q $ISO_URL

  if [ $? -ne 0 ]; then
    echo "Failed to download $ISO_FILE."
    exit 1
  fi

  echo "Download completed: $ISO_FILE"
else
  echo "$ISO_FILE already exists. Skipping download."
fi

# Step 2: Calculate the checksum of the downloaded ISO file
echo "Calculating checksum for $ISO_FILE..."
ISO_CHECKSUM=$(sha256sum $ISO_FILE | awk '{print $1}')

if [ -z "$ISO_CHECKSUM" ]; then
  echo "Failed to fetch ISO checksum."
  exit 1
fi

echo "Checksum fetched: $ISO_CHECKSUM"

# Step 3: Upload the ISO file to the Proxmox server if it doesn't already exist
if ssh "root@$PROXMOX_HOST" [ -f "/var/lib/vz/template/iso/$ISO_FILE" ]; then
  echo "$ISO_FILE already exists on the Proxmox server. Skipping upload."
else
  echo "Uploading $ISO_FILE to Proxmox server..."
  scp ./$ISO_FILE root@$PROXMOX_HOST:/var/lib/vz/template/iso/
fi

# Step 4: Check if the VM exists on Proxmox and delete it if it does
echo "Checking if VM $VM_ID exists on Proxmox..."

VM_EXISTS=$(ssh root@$PROXMOX_HOST "qm list | grep -w $VM_ID")

if [ ! -z "$VM_EXISTS" ]; then
  echo "VM $VM_ID exists. Deleting it..."
  ssh root@$PROXMOX_HOST "qm stop $VM_ID && qm destroy $VM_ID --purge --skiplock"
  if [ $? -ne 0 ]; then
    echo "Failed to delete VM $VM_ID."
    exit 1
  fi
  echo "VM $VM_ID deleted."
else
  echo "VM $VM_ID does not exist, skipping deletion."
fi

# Step 5: Run Packer with the fetched checksum, raw file name, and other variables
packer build -var "iso_checksum=$ISO_CHECKSUM" -var "iso_file=$ISO_FILE" -var "iso_version=$VERSION" -var "vm_id=$VM_ID" -var-file ../../values.auto.pkrvars.hcl .