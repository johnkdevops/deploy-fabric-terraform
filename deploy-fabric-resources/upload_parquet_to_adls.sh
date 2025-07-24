#!/bin/bash

# ----------------------------
# CONFIGURATION (edit as needed)
# ----------------------------
RESOURCE_GROUP="nyctaxi_rg"
STORAGE_ACCOUNT=""
CONTAINER_NAME=""
LOCAL_PARQUET_FILE="yellow_taxi_tripdata_2025-01.parquet"
BLOB_NAME="nyctaxi/yellow_taxi_tripdata_2025-01.parquet"
FABRIC_WORKSPACE_NAME="nyctaxi_workspace"      # Change to your actual workspace name
FABRIC_LAKEHOUSE_NAME="nyctaxi_lakehouse"      # Change to your actual lakehouse name

# ----------------------------
# Upload parquet file to ADLS Gen2
# ----------------------------
echo "Uploading Parquet file to Azure Data Lake Storage..."
az storage blob upload \
  --account-name "$STORAGE_ACCOUNT" \
  --container-name "$CONTAINER_NAME" \
  --name "$BLOB_NAME" \
  --file "$LOCAL_PARQUET_FILE" \
  --auth-mode login

# ----------------------------
# Create Delta Table in Lakehouse via Fabric REST API (placeholder)
# ----------------------------

# Generate SAS URL for the uploaded blob
echo "Generating SAS URL..."
EXPIRY=$(date -u -d "1 day" '+%Y-%m-%dT%H:%MZ')
SAS_TOKEN=$(az storage blob generate-sas \
  --account-name "$STORAGE_ACCOUNT" \
  --container-name "$CONTAINER_NAME" \
  --name "$BLOB_NAME" \
  --permissions r \
  --expiry "$EXPIRY" \
  --auth-mode login \
  --as-user \
  --output tsv)

BLOB_SAS_URL="https://${STORAGE_ACCOUNT}.blob.core.windows.net/${CONTAINER_NAME}/${BLOB_NAME}?$SAS_TOKEN"

echo "SAS URL generated: $BLOB_SAS_URL"

# TODO: Use the Fabric Lakehouse REST API or notebook to register this Parquet file as a Delta table.
# You could do this from a Spark notebook within Fabric:
# Example SQL in notebook:
#   CREATE TABLE yellow_taxi_tripdata_2025_01
#   USING DELTA
#   LOCATION 'abfss://nyctaxiparquetqvs9@nyctaxilakeadlsqvs9.dfs.core.windows.net/yellow_tripdata_2025-01.parquet';

echo "Next Step: Open a notebook in Fabric and run SQL to create the Delta Table."
# Example SQL to run in Fabric notebook:
echo "CREATE TABLE yellow_taxi_tripdata_2025_01 USING DELTA LOCATION '$BLOB_SAS_URL';"
echo "Run the above SQL in a Fabric notebook to create the Delta table."

