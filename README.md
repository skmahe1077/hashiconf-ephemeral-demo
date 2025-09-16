# HashiConf Ephemeral Resources Demo

This repository demonstrates how to securely generate and use secrets at runtime using Terraform’s **ephemeral resources** and **write-only arguments**. It shows how secrets can be used without being stored in Terraform plan or state files.

---

##  What You’ll Learn

- Generating a temporary password at runtime (ephemeral resource)  
- Storing the password in AWS Secrets Manager using a write-only argument  
- Using the password for an RDS instance without saving the secret in plan or state  
- Rotating the password by bumping a version number  
- Ensuring secrets are never exposed in logs, plan, or state

---

##  Repo Structure
```
├─ providers.tf # AWS & random provider configuration + backend example
├─ variables.tf # Region and secret_version variables
├─ main.tf # Ephemeral resource, Secrets Manager, optional RDS
└─ backend.tf # Optional: remote state configuration (S3)
```
##  Usage Instructions

1. **Initialize Terraform**
   ```bash
   terraform init
   ```
2. **Run the demo**
   ```bash
   terraform apply -auto-approve

  This will:

   - Generate a password ephemerally

   - Store it in AWS Secrets Manager via a write-only argument

   - Create an RDS instance using the secret
3. **Validate the secret is not persisted**
   ```bash
     terraform show
   ```
or inspect the state file (terraform.tfstate or S3 backend).

- ✅ Only the secret version number should appear
- ❌ The actual password will never be stored

4. **Rotate the secret**
   Update secret_version in variables.tf (e.g., change 1 → 2)
   
   Re-apply:
    ```bash
    terraform apply -auto-approve
    ```
5. **Clean up resources**
   ```bash
   terraform destroy -auto-approve
   ```
