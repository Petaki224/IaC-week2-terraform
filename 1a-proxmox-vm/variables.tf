variable "pm_endpoint" {
  description = "Proxmox API URL"
  type        = string
  default     = "https://192.168.1.32:8006/"
}

variable "pm_api_token" {
  description = "Proxmox API token: terraform@pve!tf=<uuid>"
  type        = string
  sensitive   = true
}

variable "pm_ssh_private_key_file" {
  description = "Private key that root@pve1 accepts"
  type        = string
  default     = "~/.ssh/homelab"
}

variable "node_name" {
  description = "Proxmox node to deploy on"
  type        = string
  default     = "pve1"
}

variable "image_datastore" {
  description = "Storage for the downloaded cloud image"
  type        = string
  default     = "local"
}

variable "vm_datastore" {
  description = "Storage for VM disks"
  type        = string
  default     = "local-lvm"
}

variable "bridge" {
  description = "Network bridge"
  type        = string
  default     = "vmbr0"
}

variable "ubuntu_image_url" {
  description = "Ubuntu 24.04 cloud image"
  type        = string
  default     = "https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.img"
}

variable "vm_name" {
  type    = string
  default = "ubuntu-1a"
}

variable "vm_cores" {
  type    = number
  default = 1
}

variable "vm_memory" {
  description = "Memory in MB"
  type        = number
  default     = 1024
}
