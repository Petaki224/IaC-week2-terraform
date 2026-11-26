variable "subscription_id" {
  description = "Azure subscription ID (az account show --query id -o tsv)"
  type        = string
}

variable "resource_group_name" {
  description = "EXISTING resource group (used as data source, never destroyed)"
  type        = string
}

variable "ssh_key_name" {
  description = "Name of the SSH public key you uploaded to Azure"
  type        = string
}

variable "ssh_key_resource_group" {
  description = "Resource group of that SSH key (defaults to resource_group_name)"
  type        = string
  default     = null
}

variable "prefix" {
  type    = string
  default = "iac-1b"
}

variable "vm_size" {
  description = "Standard_B2ats_v2 or Standard_DS1_v2"
  type        = string
  default     = "Standard_DS1_v2"
}

variable "admin_username" {
  type    = string
  default = "iac"
}
