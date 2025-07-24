#!/bin/bash

TF_OUTPUT_FILE="tf_outputs.json"

export TF_VAR_storage_account_name=$(jq -r '.storage_account_name.value' $TF_OUTPUT_FILE)
export TF_VAR_fabric_capacity_name=$(jq -r '.fabric_capacity_name.value' $TF_OUTPUT_FILE)
export TF_VAR_capacity_id=$(jq -r '.capacity_id.value' $TF_OUTPUT_FILE)
export TF_VAR_container_name=$(jq -r '.container_name.value' $TF_OUTPUT_FILE)
export TF_VAR_resource_group_name=$(jq -r '.resource_group_name.value' $TF_OUTPUT_FILE)

echo "Exported Terraform variables:"
echo "  TF_VAR_storage_account_name = $TF_VAR_storage_account_name"
echo "  TF_VAR_fabric_capacity_name = $TF_VAR_fabric_capacity_name"
echo "  TF_VAR_capacity_id = $TF_VAR_capacity_id"
echo "  TF_VAR_container_name = $TF_VAR_container_name"
echo "  TF_VAR_resource_group_name = $TF_VAR_resource_group_name"
# Check if the variables are set
if [[ -z "$TF_VAR_storage_account_name" || -z "$TF_VAR_fabric_capacity_name" || -z "$TF_VAR_capacity_id" || -z "$TF_VAR_container_name" || -z "$TF_VAR_resource_group_name" ]]; then
  echo "Error: One or more Terraform variables are not set."
  exit 1
fi