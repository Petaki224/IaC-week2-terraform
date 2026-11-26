# ---------- Proxmox connection ----------
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
  description = "Private key that root@pve1 accepts (used to upload cloud-init snippets)"
  type        = string
  default     = "~/.ssh/homelab"
}

variable "node_name" {
  type    = string
  default = "pve1"
}

# ---------- Storage / network ----------
variable "image_datastore" {
  description = "Storage for the downloaded cloud image"
  type        = string
  default     = "local"
}

variable "snippets_datastore" {
  description = "Storage with 'snippets' enabled (cloud-init user-data)"
  type        = string
  default     = "local"
}

variable "vm_datastore" {
  description = "Storage for VM disks"
  type        = string
  default     = "local-lvm"
}

variable "bridge" {
  type    = string
  default = "vmbr0"
}

variable "ubuntu_image_url" {
  description = "Ubuntu 24.04 cloud image"
  type        = string
  default     = "https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.img"
}

# ---------- VM sizing ----------
variable "webserver_count" {
  type    = number
  default = 2
}

variable "vm_cores" {
  type    = number
  default = 1
}

variable "vm_memory" {
  description = "Memory in MB"
  type        = number
  default     = 2048
}

variable "vm_disk_size" {
  description = "Disk size in GB"
  type        = number
  default     = 10
}

# ---------- Cloud-init ----------
variable "vm_user" {
  description = "User created by cloud-init (passwordless sudo)"
  type        = string
  default     = "iac"
}

variable "ssh_public_key_file" {
  description = "ED25519 public key placed on the VMs"
  type        = string
  default     = "~/.ssh/homelab.pub"
}

variable "packages" {
  description = "Packages installed by cloud-init"
  type        = list(string)
  default     = ["wget", "ntpdate"]
}
