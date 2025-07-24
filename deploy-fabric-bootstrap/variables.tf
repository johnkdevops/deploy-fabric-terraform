variable "tenant_id" {
  description = "The Azure AD tenant ID"
  type        = string
}

variable "prefix" {
  type        = string
  default     = "nyctaxi"
  description = "Prefix to use for naming all Fabric resources"
}

variable "random_suffix_length" {
  type        = number
  default     = 6
  description = "Length of the random suffix to append to resource names"
}

variable "admin_email" {
  description = "Email address of the Fabric administrator"
  type        = string
}

variable "admin_user_object_id" {
  description = "The object ID of the admin user for Fabric resources"
  type        = string
}

variable "subscription_id" {
  description = "The Azure subscription ID where resources will be created"
  type        = string
}

variable "location" {
  description = "The Azure region where resources will be created"
  type        = string
}

variable "fabric_capacity_sku" {
  type        = string
  description = "SKU for the Fabric capacity (e.g., F2)"
  validation {
    condition     = contains(["F2", "F4", "F8", "F16"], var.fabric_capacity_sku)
    error_message = "Invalid SKU. Must be one of: F2, F4, F8, F16."
  }
}

variable "storage_account_name" {
  type        = string
  description = "The name of the ADLS Gen2 storage account"
}

variable "container_name" {
  type        = string
  description = "The name of the container in the ADLS Gen2 account"
}

variable "spn_object_id" {
  type        = string
  description = "The object ID of the service principal to assign roles to"
}

