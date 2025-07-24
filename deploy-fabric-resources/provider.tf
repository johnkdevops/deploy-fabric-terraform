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
  subscription_id            = var.subscription_id
  skip_provider_registration = true
}

provider "fabric" {
  client_id     = var.client_id
  client_secret = var.client_secret
  tenant_id     = var.tenant_id
}
