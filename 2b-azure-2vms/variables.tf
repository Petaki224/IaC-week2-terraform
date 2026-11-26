variable "subscription_id" {
  description = "Azure subscription ID (az account show --query id -o tsv)"
  type        = string
}

variable "resource_group_name" {
  description = "EXISTING resource group (used as data source, never destroyed)"
  type        = string
}

variable "ssh_key_name" {
  description = "Name of the SSH public key you uploaded to Azure earlier"
  type        = string
}

variable "ssh_key_resource_group" {
  description = "Resource group of that SSH key (defaults to resource_group_name)"
  type        = string
  default     = null
}

variable "prefix" {
  type    = string
  default = "iac-2b"
}

variable "vm_count" {
  description = "Number of identical VMs"
  type        = number
  default     = 2
}

variable "vm_size" {
  description = "Standard_B2ats_v2 or Standard_DS1_v2"
  type        = string
  default     = "Standard_DS1_v2"
}

variable "admin_username" {
  description = "User created on the VMs"
  type        = string
  default     = "iac"
}

variable "allowed_ssh_cidr" {
  description = "Who may SSH in. Best: your home public IP, e.g. 1.2.3.4/32"
  type        = string
  default     = "*"
}

variable "vnet_cidr" {
  type    = string
  default = "10.20.0.0/16"
}

variable "subnet_cidr" {
  type    = string
  default = "10.20.1.0/24"
}
