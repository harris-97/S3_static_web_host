# 🚀 Project Overview

This project includes Terraform configuration files for managing infrastructure, along with supporting files for handling state, variables, and deletions.

## 📂 Files Overview

### 1. `.gitignore` 🛑

- Specifies files and directories to be ignored by Git to prevent unnecessary or sensitive files from being committed.
- **Terraform State Files:**
  - `terraform.tfstate` and `terraform.tfstate.backup` 📜 contain the current state of the infrastructure and backups, which should not be tracked by Git.
  - `tfplan` is a Terraform plan output file used for reviewing changes before applying them.
- **Terraform Working Directory:**
  - `.terraform/` is a local directory containing provider plugins and other Terraform-related metadata.
  - `.terraform.lock.hcl` locks provider versions to ensure consistency and should not be manually modified.
- **Logs and Temporary Files:**
  - `*.log` 📝 ignores all log files generated during Terraform operations.
  - `*.bak` ignores backup files created during state management.

### 2. `main.tf` 🌍

- The primary Terraform configuration file.
- Defines the infrastructure resources and their configurations.
- **Key Resources:**
  - `aws_s3_bucket` (`website`) 🪣: Creates an S3 bucket to host a static website.
  - `aws_s3_bucket_versioning` (`versioning`) 🔄: Enables versioning for the S3 bucket.
  - `aws_s3_bucket_ownership_controls` (`ownership`) 👑: Configures ownership settings to ensure the bucket owner has full control.
  - `aws_s3_bucket_public_access_block` (`public_access`) 🔓: Manages public access settings for the bucket, allowing public access.
  - `aws_s3_bucket_website_configuration` (`website_config`) 🌐: Configures the bucket to host a static website, defining `index.html` and `error.html` as the main pages.
  - `null_resource` (`upload_files`) 📤: Uses a local-exec provisioner to upload website files from a local directory to the S3 bucket with public read access.
  - `output` (`bucket_name` & `website_url`) 📎: Outputs the S3 bucket name and the website endpoint after deployment.

### 3. `provider.tf` ☁️

- Configures Terraform providers.
- **Key Components:**
  - `terraform` block: Specifies required providers.
  - `required_providers`: Defines the AWS provider, sourced from HashiCorp with a version constraint (`~> 5.0`).
  - `provider` block: Configures the AWS provider and sets the region using the `var.region` variable.

### 4. `variables.tf` 🎛️

- Defines variables used across Terraform configurations.
- **Key Variables:**
  - `region` 📍: Specifies the AWS region where resources will be deployed (default: `us-east-1`).
  - `bucket_name` 🏷️: Defines the name of the S3 bucket to be created (default: `mybucket-unique-name`).

### 5. `terraform.tfvars` 🛠️

- Contains values for the defined variables in `variables.tf`.
- Typically used to manage environment-specific configurations.
- **Key Assignments:**
  - `region = "us-east-1"` 📌: Specifies the AWS region where resources will be deployed.
  - `bucket_name = "unique-bucket-name-1"` 📦: Defines the name of the S3 bucket to be created.

### 6. `delete.json` 🗑️

- A JSON file specifying objects to be deleted from the S3 bucket.
- Contains a list of files and their corresponding version IDs.
- **Key Structure:**
  - `Objects`: A list containing details of files marked for deletion.
  - Each object includes:
    - `Key` 🔑: The file path within the S3 bucket.
    - `VersionId` 🏷️: The version identifier for the specific file.
- **Example Entries:**
  ```json
  {
      "Key": "index.html",
      "VersionId": "QgNQAeeLgDHd40KWgYcCFVeHcT0MtEcw"
  }
  ```

## 📖 Usage

1. **Initialize Terraform** ⚙️
   ```sh
   terraform init
   ```
2. **Validate Configuration** ✅
   ```sh
   terraform validate
   ```
3. **Plan Infrastructure Changes** 📝
   ```sh
   terraform plan -out=tfplan
   ```
4. **Apply Changes** 🚀
   ```sh
   terraform apply tfplan
   ```
5. **Destroy Infrastructure (if needed)** ❌
   ```sh
   terraform destroy
   ```

## 🔍 Notes

- Ensure Terraform is installed before running these commands.
- The `.gitignore` file prevents committing sensitive state files.
- Modify `terraform.tfvars` to customize infrastructure parameters.
- `delete.json` can be used to manage file deletions programmatically by referencing specific file versions.

## ✍️ Author

Created by harris-97