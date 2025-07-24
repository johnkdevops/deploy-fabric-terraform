data "azurerm_resource_group" "fabric_rg" {
  name = var.resource_group_name
}

resource "fabric_workspace" "workspace" {
  display_name = "NYCTaxiWorkspace"
  capacity_id  = var.fabric_capacity_id
}

resource "fabric_lakehouse" "lakehouse" {
  display_name = "NYCTaxiLakehouse"
  workspace_id = fabric_workspace.workspace.id
}

# resource "fabric_sql_database" "sqldb" {
#   workspace_id = fabric_workspace.workspace.id
#   display_name = "NYCTaxiDB"
# }

output "workspace_id" {
  value = fabric_workspace.workspace.id
}

output "lakehouse_id" {
  value = fabric_lakehouse.lakehouse.id
}

# output "sqldb_id" {
#   value = fabric_sql_database.sqldb.id
# }