variable "tenant_id" {
  description = "The Azure AD tenant ID"
  type        = string
}

variable "subscription_id" {
  description = "The Azure subscription ID where resources will be created"
  type        = string
}

variable "prefix" {
  type        = string
  description = "Naming prefix for all Fabric resources"
}

variable "client_id" {
  description = "The client ID of the Service Principal"
  type        = string
}

variable "client_secret" {
  description = "The client secret of the Service Principal"
  type        = string
  sensitive   = true
}

variable "resource_group_name" {
  description = "The name of the resource group where Fabric resources will be created"
  type        = string
}

variable "fabric_capacity_uuid" {
  description = "The UUID (GUID) of the Fabric Capacity — used by Fabric resources like workspaces"
  type        = string
}

variable "fabric_capacity_id" {
  description = "The full Azure Resource Manager (ARM) ID of the Fabric Capacity — useful for role assignments"
  type        = string
}

# Uncomment if assigning SPN roles to workspace/lakehouse
# variable "spn_object_id" {
#   description = "The object ID of the Service Principal to assign roles"
#   type        = string
# }
