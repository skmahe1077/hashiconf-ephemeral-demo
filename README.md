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

