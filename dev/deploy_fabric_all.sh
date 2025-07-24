#!/bin/bash
set -e

echo "Step 1: Terraform apply to create capacity and storage..."
terraform apply -auto-approve

echo "Step 2: Extract outputs from tf_outputs.json into terraform.tfvars..."
TF_OUTPUT_FILE="tf_outputs.json"

if [[ ! -f $TF_OUTPUT_FILE ]]; then
  echo "Error: $TF_OUTPUT_FILE not found! Make sure to run 'terraform output -json > tf_outputs.json' after apply."
  exit 1
fi

fabric_capacity_id=$(jq -r '.fabric_capacity_id.value' $TF_OUTPUT_FILE)
fabric_capacity_uuid=$(jq -r '.fabric_capacity_uuid.value' $TF_OUTPUT_FILE)
storage_account_name=$(jq -r '.storage_account_name.value' $TF_OUTPUT_FILE)
parquet_container_name=$(jq -r '.parquet_container_name.value' $TF_OUTPUT_FILE)
resource_group_name=$(jq -r '.resource_group_name.value' $TF_OUTPUT_FILE)

cat > terraform.tfvars <<EOF
fabric_capacity_id    = "${fabric_capacity_id}"
fabric_capacity_uuid  = "${fabric_capacity_uuid}"
storage_account_name  = "${storage_account_name}"
container_name        = "${parquet_container_name}"
resource_group_name   = "${resource_group_name}"
prefix                = "nyctaxi"
EOF

echo "terraform.tfvars created/updated."

echo "Step 3: Terraform apply to create workspace, lakehouse, and upload parquet file..."
terraform apply -auto-approve

echo "Deployment complete!"
