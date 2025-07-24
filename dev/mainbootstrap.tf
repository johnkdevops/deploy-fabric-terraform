resource "azurerm_resource_group" "fabric_rg" {
  name     = "${var.prefix}_rg"
  location = var.location

  # Uncomment for production to prevent accidental deletion
  # lifecycle {
  #   prevent_destroy = true
  # }
}

resource "random_string" "suffix" {
  length  = var.random_suffix_length
  upper   = false
  lower   = true
  numeric = true
  special = false
}

resource "azurerm_storage_account" "adls" {
  name                      = "${var.prefix}${var.storage_account_name}${random_string.suffix.result}"
  resource_group_name       = azurerm_resource_group.fabric_rg.name
  location                  = azurerm_resource_group.fabric_rg.location
  account_tier              = "Standard"
  account_replication_type  = "LRS"
  is_hns_enabled            = true
  enable_https_traffic_only = true

  tags = {
    environment = "lab"
    project     = "${var.prefix}_project"
  }
}

resource "azurerm_storage_container" "parquet" {
  name                  = "${var.prefix}${var.container_name}${random_string.suffix.result}"
  storage_account_name  = azurerm_storage_account.adls.name
  container_access_type = "private"
}

# data "azuread_service_principal" "spn_object_id" {
#   display_name = "NYCTaxiSPN"
# }

# data "azuread_users" "admin" {
#   user_principal_names = [var.admin_email]
# }

resource "azurerm_role_assignment" "blob_contributor" {
  scope                = azurerm_storage_account.adls.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = var.spn_object_id
  # principal_id         = data.azuread_service_principal.spn_object_id.object_id
}

resource "azurerm_role_assignment" "example" {
  scope                = azurerm_storage_account.adls.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = var.admin_user_object_id
  # principal_id         = data.azuread_users.admin.users[0].object_id
}

module "fabric_capacity" {
  source = "github.com/Azure/azure-data-labs-modules/terraform/fabric/fabric-capacity"

  basename          = "${var.prefix}fabf2cap${random_string.suffix.result}"
  resource_group_id = azurerm_resource_group.fabric_rg.id
  location          = var.location
  sku               = var.fabric_capacity_sku
  admin_email       = var.admin_email
}



