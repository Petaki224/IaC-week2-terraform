terraform {
  required_version = ">= 1.6"

  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "~> 0.124"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.5"
    }
  }
}

provider "proxmox" {
  endpoint  = var.pm_endpoint
  api_token = var.pm_api_token
  insecure  = true # self-signed certificate on the Proxmox node

  # Cloud-init snippets are uploaded over SSH (the API can't upload snippets)
  ssh {
    username    = "root"
    private_key = file(pathexpand(var.pm_ssh_private_key_file))
  }
}
