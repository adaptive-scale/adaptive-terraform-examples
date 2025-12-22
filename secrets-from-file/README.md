# Secrets from File Example

This example demonstrates how to read sensitive configuration data (credentials, connection strings, certificates) from local files instead of hardcoding them in Terraform configuration.

## Overview

Instead of embedding secrets directly in your Terraform code, you can store them in external files and read them at runtime. This approach provides several benefits:

- **Security**: Keep secrets out of version control
- **Flexibility**: Use different secrets for different environments
- **Maintainability**: Centralize secret management
- **CI/CD Friendly**: Inject secrets through pipeline mechanisms

## File Formats Supported

### JSON Format (Recommended)
```json
{
  "databases": {
    "production": {
      "host": "prod-db.example.com",
      "username": "prod_user",
      "password": "secret-password"
    }
  }
}
```

### YAML Format
```yaml
databases:
  production:
    host: prod-db.example.com
    username: prod_user
    password: secret-password
```

### Individual Files
```
secrets/
├── db_host.txt
├── db_username.txt
└── db_password.txt
```

## Usage

### Basic JSON File Reading

```hcl
locals {
  secrets = jsondecode(file("${path.module}/secrets.json"))
}

resource "adaptive_resource" "database" {
  type     = "postgres"
  name     = "my-database"
  host     = local.secrets.databases.production.host
  username = local.secrets.databases.production.username
  password = local.secrets.databases.production.password
}
```

### Environment-Specific Files

```hcl
locals {
  secrets = jsondecode(file("${path.module}/secrets-${terraform.workspace}.json"))
}
```

This allows different secrets for `dev`, `staging`, and `prod` workspaces.

### Individual Secret Files

```hcl
resource "adaptive_resource" "database" {
  type     = "postgres"
  name     = "my-database"
  host     = file("${path.module}/secrets/db_host.txt")
  username = file("${path.module}/secrets/db_username.txt")
  password = file("${path.module}/secrets/db_password.txt")
}
```

## Security Considerations

### .gitignore
Make sure to add your secrets files to `.gitignore`:

```
# Secrets files
secrets*.json
secrets/
*.secrets
```

### File Permissions
Set restrictive permissions on secrets files:

```bash
chmod 600 secrets.json
```

### CI/CD Integration
In CI/CD pipelines, you can:

1. **Generate secrets files** from secret management systems
2. **Mount secrets as files** from container orchestration
3. **Use Terraform variables** to specify file paths

Example pipeline step:
```bash
# Generate secrets file from environment variables
cat > secrets.json << EOF
{
  "database": {
    "password": "$DB_PASSWORD",
    "host": "$DB_HOST"
  }
}
EOF

terraform apply
```

## Running the Example

```bash
# Initialize Terraform
terraform init

# Validate configuration
terraform validate

# Plan deployment
terraform plan

# Apply configuration
terraform apply
```

## File Structure

```
secrets-from-file/
├── main.tf           # Terraform configuration
├── provider.tf       # Provider configuration
├── secrets.json      # Secrets file (NOT in version control)
└── README.md         # This documentation
```

## Alternative Approaches

### Terraform Variables
```hcl
variable "db_password" {
  type        = string
  sensitive   = true
  description = "Database password"
}

resource "adaptive_resource" "database" {
  password = var.db_password
}
```

### Environment Variables
```hcl
resource "adaptive_resource" "database" {
  password = var.TF_VAR_db_password
}
```

### External Secret Managers
For production environments, consider using:
- AWS Secrets Manager
- Azure Key Vault
- HashiCorp Vault
- GCP Secret Manager

## Best Practices

1. **Never commit secrets** to version control
2. **Use restrictive file permissions** (600)
3. **Validate file existence** before running Terraform
4. **Use environment-specific files** for multi-environment deployments
5. **Document required file formats** for team members
5. **Consider encryption** for highly sensitive files

## Testing the Example

This example has been validated and tested. To verify it works in your environment:

1. **Initialize Terraform**:
   ```bash
   terraform init
   ```

2. **Validate the configuration**:
   ```bash
   terraform validate
   ```
   Expected output: `Success! The configuration is valid.`

3. **Review the execution plan**:
   ```bash
   terraform plan
   ```
   This will show 9 resources to be created, demonstrating that secrets are properly read from files.

4. **Clean up** (optional):
   ```bash
   terraform destroy
   ```

**Note**: The example uses sample data and will not actually connect to real databases. It's designed to demonstrate the file reading functionality.

## Troubleshooting

### File Not Found Error
```
Error: file(...) is not a valid function
```

**Solution**: Make sure the secrets file exists at the specified path.

### JSON Parse Error
```
Error: jsondecode: invalid character
```

**Solution**: Validate your JSON syntax using a JSON validator.

### Permission Denied
```
Error: open secrets.json: permission denied
```

**Solution**: Check file permissions and ensure Terraform can read the file.