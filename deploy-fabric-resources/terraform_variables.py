import json
from azure.identity import DefaultAzureCredential
from azure.storage.blob import BlobServiceClient

# Load tf outputs
with open("tf_outputs.json", "r") as f:
    outputs = json.load(f)

storage_account_name = outputs["storage_account_name"]["value"]
container_name = outputs["container_name"]["value"]

# Define file to upload
file_path = "./data/sample.parquet"
blob_name = "sample.parquet"

# Build blob endpoint
account_url = f"https://{storage_account_name}.blob.core.windows.net"
credential = DefaultAzureCredential()

# Connect and upload
blob_service_client = BlobServiceClient(account_url=account_url, credential=credential)
blob_client = blob_service_client.get_blob_client(container=container_name, blob=blob_name)

with open(file_path, "rb") as data:
    blob_client.upload_blob(data, overwrite=True)

print("Parquet file uploaded successfully!")
