terraform {
  required_providers {
    fabric = {
      source  = "microsoft/fabric"
      version = "1.3.0"
    }
    azurerm = {
      version = "= 3.70.0"
    }
    azapi = {
      source  = "azure/azapi"
      version = "=1.12.0"
    }
  }
}

provider "azurerm" {
  features {}

  skip_provider_registration = true
}
