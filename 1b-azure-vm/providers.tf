terraform {
  required_version = ">= 1.6"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

# Log in first with `az login`
provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}
