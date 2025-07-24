#!/bin/bash
set -e

# Set sensitive Terraform variables as environment variables
export TF_VAR_tenant_id=""
export TF_VAR_subscription_id=""
export TF_VAR_client_id=""
export TF_VAR_client_secret=""

echo "Terraform sensitive environment variables set."

# Optional: Extract dynamic vars from tf_outputs.json and update terraform.tfvars
if [[ -f tf_outputs.json ]]; then
  echo "Loading dynamic outputs from tf_outputs.json..."
  ./extract_tf_outputs.sh
fi

echo "Setup complete. You can now run 'terraform plan' and 'terraform apply' as needed."
