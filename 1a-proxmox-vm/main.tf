# Opdracht 1A: 1 Ubuntu VM, 1 vCPU, 1024 MB.
# No cloud-init: the VM boots to a login prompt but you can't log in.
# That's the point of this exercise -> terraform destroy afterwards, keep the code.

resource "proxmox_download_file" "ubuntu" {
  content_type = "iso"
  datastore_id = var.image_datastore
  node_name    = var.node_name
  url          = var.ubuntu_image_url
  file_name    = "noble-cloudimg-1a.img"
}

resource "proxmox_virtual_environment_vm" "ubuntu" {
  name      = var.vm_name
  node_name = var.node_name

  cpu {
    cores = var.vm_cores
    type  = "x86-64-v2-AES"
  }

  memory {
    dedicated = var.vm_memory
  }

  disk {
    datastore_id = var.vm_datastore
    file_id      = proxmox_download_file.ubuntu.id
    interface    = "virtio0"
    size         = 10
  }

  network_device {
    bridge = var.bridge
  }

  operating_system {
    type = "l26"
  }

  serial_device {}
}
