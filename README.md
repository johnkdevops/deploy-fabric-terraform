# 🚀 Deploy Fabric Infrastructure using Terraform

This repository automates the deployment of **Microsoft Fabric infrastructure** using **Terraform**. It provisions Azure resources such as a Resource Group, Storage Account, Synapse Workspace, and Databricks Workspace, and configures secret outputs for use in **Azure DevOps pipelines**.

---

## 🧩 Overview

The Terraform configuration in this repository:

- Creates Azure infrastructure to support Microsoft Fabric.
- Sets up a Databricks workspace (optional cluster creation).
- Deploys a Synapse workspace integrated with Azure Data Lake.
- Outputs key connection details (endpoints, names, credentials) to be stored securely in Azure DevOps variable groups.
- Prepares for **.dacpac** artifact deployments via Azure DevOps pipelines to a Fabric Lakehouse.

---

## 🏗️ Architecture

```text
Root Module
├── modules/
│   ├── resource_group/
│   ├── storage/
│   ├── databricks/
│   ├── synapse/
│   ├── secrets/
│
├── main.tf
├── variables.tf
├── outputs.tf
└── terraform.tfvars
```

Each module is responsible for deploying a specific component of the Azure infrastructure.

---

## ⚙️ Prerequisites

Before deploying, ensure you have the following:

- Azure CLI authenticated (`az login`)
- Terraform ≥ v1.6.0
- Azure subscription and service principal with `Contributor` role
- Azure DevOps project and repository access
- Properly configured backend (S3 or Azure Blob)

---

## 🔐 Azure DevOps Integration

The following Terraform outputs are stored as **variables in Azure DevOps Variable Groups** for pipeline use:

- `storage_account_name`
- `storage_account_dfs_endpoint`
- `synapse_workspace_name`
- `databricks_workspace_url`
- `synapse_username`
- `synapse_password`

These secrets are referenced in `azure-pipelines.yml` to deploy `.dacpac` artifacts into Microsoft Fabric.

---

## 🚦 Deployment Steps

1. **Clone the repo**
   ```bash
   git clone https://github.com/johnkdevops/deploy-fabric-terraform.git
   cd deploy-fabric-terraform
   ```

2. **Initialize Terraform**
   ```bash
   terraform init
   ```

3. **Validate configuration**
   ```bash
   terraform validate
   ```

4. **Plan and apply**
   ```bash
   terraform plan -out plan.tfplan
   terraform apply plan.tfplan
   ```

5. **Review outputs**
   ```bash
   terraform output
   ```

---

## 🧪 Azure DevOps CI/CD Pipeline

The included **`azure-pipelines.yml`** triggers on commits to your Azure DevOps repo.  
It runs Terraform commands and produces a `.dacpac` artifact for deployment to **SQL Server Management Studio** or **Fabric Lakehouse**.

---

## 🧭 Future Enhancements

- Add job cluster provisioning directly in Azure DevOps pipeline.
- Integrate Fabric Lakehouse deployment via Terraform and pipeline automation.
- Implement role-based access control for Data Engineers.

---

## 👏 Credits

Developed by **John Kennedy** as part of the **AI Fabric Data Engineering course** — empowering DevOps and Data Engineers to build scalable, automated Azure infrastructures.
