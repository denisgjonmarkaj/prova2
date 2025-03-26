## How to run

### (Optional) # Fetch S3 Access and Secret key from OCI Vault and export them as env variables

Example for the Development environments:
```bash
export AWS_ACCESS_KEY_ID=$(oci secrets secret-bundle get --secret-id "ocid1.vaultsecret.oc1.eu-frankfurt-1.amaaaaaarhmdlkaat26e6tfobamrzxdila5qy54sgxrq4ustsdltj4ygo7qq" --query "data.\"secret-bundle-content\".content" --raw-output --profile BMW-TF | base64 --decode)
export AWS_SECRET_ACCESS_KEY=$(oci secrets secret-bundle get --secret-id "ocid1.vaultsecret.oc1.eu-frankfurt-1.amaaaaaarhmdlkaaoar4iyl57uhwyxffxhkpt6kquauygjzgqcpqiraxtgsq" --query "data.\"secret-bundle-content\".content" --raw-output --profile BMW-TF | base64 --decode)
```

### 1. Initialize Terraform

First, cd into the environment parent folder (e.g. `/environments/development`)

Run the following command to initialize the working directory and configure the backend:

```bash
terraform init
```

### 2. Validate Terraform code

Check for syntax errors or configuration issues:

```bash
terraform validate
```

### 3. Plan infrastructure changes

Preview the changes Terraform will apply:

```bash
terraform plan -out=tfplan
```
### 4. Apply the Terraform plan

Apply the infrastructure changes:

```bash
terraform apply tfplan
```