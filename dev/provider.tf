terraform {
  required_version = ">= 1.8, < 2.0"
  required_providers {
    fabric = {
      source  = "microsoft/fabric"
      version = "1.3.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

# Configure the Microsoft Fabric Terraform Provider
provider "fabric" {
  tenant_id                    = var.tenant_id
  client_id                    = var.client_id
  client_certificate_file_path = var.client_certificate
  client_certificate_password  = var.client_password
}