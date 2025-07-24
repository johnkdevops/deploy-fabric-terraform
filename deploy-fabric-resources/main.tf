data "azurerm_resource_group" "fabric_rg" {
  name = var.resource_group_name
}

# Create a Fabric Workspace
resource "fabric_workspace" "workspace" {
  display_name = "${var.prefix}_workspace"
  capacity_id  = var.fabric_capacity_uuid
}

# Create a Lakehouse inside the workspace
resource "fabric_lakehouse" "lakehouse" {
  display_name = "${var.prefix}_lakehouse"
  workspace_id = fabric_workspace.workspace.id
}

# Upload a .parquet file to ADLS Gen2 container
# resource "null_resource" "upload_parquet" {
#   provisioner "local-exec" {
#     command = <<EOT
#       az storage blob upload \
#         --account-name ${data.azurerm_storage_account.storage.name} \
#         --container-name ${data.azurerm_storage_container.lakehouse_container.name} \
#         --name ${var.parquet_blob_name} \
#         --file ${var.parquet_file_path} \
#         --auth-mode login
#     EOT
#   }

#   depends_on = [fabric_lakehouse.lakehouse]
# }

