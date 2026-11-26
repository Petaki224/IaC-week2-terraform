# Opdracht 2A: 3 Ubuntu 24.04 VMs (1 vCPU, 2048 MB) on Proxmox.
#   - one resource for 2x "webserver", one resource for 1x "databaseserver"
#   - cloud-init: user with passwordless sudo, ED25519 key, packages wget + ntpdate
#   - the IP of every VM is written to ip_addresses.txt (see outputs.tf)

locals {
  ssh_public_key = trimspace(file(pathexpand(var.ssh_public_key_file)))
}

# Ubuntu 24.04 cloud image, downloaded once onto the node
resource "proxmox_download_file" "ubuntu" {
  content_type = "iso"
  datastore_id = var.image_datastore
  node_name    = var.node_name
  url          = var.ubuntu_image_url
  file_name    = "noble-cloudimg-2a.img"
}

# ---------- Cloud-init user-data (one snippet per VM, for the hostname) ----------
resource "proxmox_virtual_environment_file" "webserver_user_data" {
  count        = var.webserver_count
  content_type = "snippets"
  datastore_id = var.snippets_datastore
  node_name    = var.node_name

  source_raw {
    file_name = "webserver-${count.index + 1}-user-data.yaml"
    data = templatefile("${path.module}/cloud-init/user-data.yaml.tftpl", {
      hostname       = "webserver-${count.index + 1}"
      username       = var.vm_user
      ssh_public_key = local.ssh_public_key
      packages       = var.packages
    })
  }
}

resource "proxmox_virtual_environment_file" "databaseserver_user_data" {
  content_type = "snippets"
  datastore_id = var.snippets_datastore
  node_name    = var.node_name

  source_raw {
    file_name = "databaseserver-user-data.yaml"
    data = templatefile("${path.module}/cloud-init/user-data.yaml.tftpl", {
      hostname       = "databaseserver"
      username       = var.vm_user
      ssh_public_key = local.ssh_public_key
      packages       = var.packages
    })
  }
}

# ---------- VMs ----------
resource "proxmox_virtual_environment_vm" "webserver" {
  count     = var.webserver_count
  name      = "webserver-${count.index + 1}"
  node_name = var.node_name
  tags      = ["iac", "week2", "webserver"]

  agent {
    enabled = true
  }

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
    size         = var.vm_disk_size
  }

  network_device {
    bridge = var.bridge
  }

  initialization {
    datastore_id      = var.vm_datastore
    user_data_file_id = proxmox_virtual_environment_file.webserver_user_data[count.index].id

    ip_config {
      ipv4 {
        address = "dhcp"
      }
    }
  }

  operating_system {
    type = "l26"
  }

  serial_device {}
}

resource "proxmox_virtual_environment_vm" "databaseserver" {
  name      = "databaseserver"
  node_name = var.node_name
  tags      = ["iac", "week2", "databaseserver"]

  agent {
    enabled = true
  }

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
    size         = var.vm_disk_size
  }

  network_device {
    bridge = var.bridge
  }

  initialization {
    datastore_id      = var.vm_datastore
    user_data_file_id = proxmox_virtual_environment_file.databaseserver_user_data.id

    ip_config {
      ipv4 {
        address = "dhcp"
      }
    }
  }

  operating_system {
    type = "l26"
  }

  serial_device {}
}
