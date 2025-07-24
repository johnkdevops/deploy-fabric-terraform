output "resource_group_name" {
  value = azurerm_resource_group.fabric_rg.name
}

output "fabric_capacity_id" {
  value       = module.fabric_capacity.id
  description = "The full ARM ID of the Fabric capacity."
}

output "fabric_capacity_uuid" {
  description = "The name (UUID) of the Fabric Capacity"
  value       = split("/", module.fabric_capacity.id)[length(split("/", module.fabric_capacity.id)) - 1]
}

output "storage_account_name" {
  value       = azurerm_storage_account.adls.name
  description = "The name of the ADLS Gen2 storage account."
}

output "storage_account_id" {
  value       = azurerm_storage_account.adls.id
  description = "The resource ID of the storage account."
}

output "parquet_container_name" {
  value       = azurerm_storage_container.parquet.name
  description = "The name of the container used for Parquet file uploads."
}

output "parquet_container_url" {
  value       = "https://${azurerm_storage_account.adls.name}.blob.core.windows.net/${azurerm_storage_container.parquet.name}"
  description = "The full blob URL to the Parquet container in ADLS Gen2."
}

