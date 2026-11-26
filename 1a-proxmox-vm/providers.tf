terraform {
  required_version = ">= 1.6"

  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "~> 0.124"
    }
  }
}

provider "proxmox" {
  endpoint  = var.pm_endpoint
  api_token = var.pm_api_token
  insecure  = true # self-signed certificate on the Proxmox node

  # Creating a disk from a cloud image is done over SSH on the node
  ssh {
    username    = "root"
    private_key = file(pathexpand(var.pm_ssh_private_key_file))
  }
}
