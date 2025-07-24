#!/bin/bash
set -e

# Usage: ./upload_parquet.sh <storage_account> <container> <local_file_path> <blob_name>
STORAGE_ACCOUNT_NAME=$1
CONTAINER_NAME=$2
FILE_PATH=$3
BLOB_NAME=$4

echo "Uploading $FILE_PATH to container $CONTAINER_NAME as $BLOB_NAME in $STORAGE_ACCOUNT_NAME..."

# Upload parquet file using Azure CLI
az storage blob upload \
  --account-name "$STORAGE_ACCOUNT_NAME" \
  --container-name "$CONTAINER_NAME" \
  --name "$BLOB_NAME" \
  --file "$FILE_PATH" \
  --auth-mode login

# Check if the upload was successful
if [ $? -eq 0 ]; then
  echo "✅ File uploaded successfully to $CONTAINER_NAME/$BLOB_NAME"
else
  echo "❌ Failed to upload file to $CONTAINER_NAME/$BLOB_NAME"
  exit 1
fi
# Optionally, you can list the blobs in the container to verify
az storage blob list \
  --account-name "$STORAGE_ACCOUNT_NAME" \
  --container-name "$CONTAINER_NAME" \
  --output table