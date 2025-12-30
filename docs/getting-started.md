---
layout: default
title: Getting Started
---

[← Back to Home](index.md)

# Getting Started with Adaptive Terraform Provider

Quick start guide to begin using the Adaptive Terraform Provider.

## Prerequisites

- **Terraform** 0.13 or later
- **Adaptive Account** (sign up at [adaptive.live](https://adaptive.live))
- **API Credentials** for your integrations

## Installation

### 1. Install Terraform

```bash
# macOS (Homebrew)
brew install terraform

# Linux (Ubuntu/Debian)
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform

# Windows (Chocolatey)
choco install terraform
```

Verify installation:
```bash
terraform version
```

### 2. Configure Adaptive Provider

Create a `provider.tf` file:

```hcl
terraform {
  required_providers {
    adaptive = {
      source  = "adaptive-scale/adaptive"
      version = "~> 0.1.18"
    }
  }
}

provider "adaptive" {
  # Configuration options, optional. Will automatically pickup from the system
  api_endpoint = "https://api.adaptive.live"
  api_key      = var.adaptive_api_key
}
```

### 3. Set Up Variables

Create a `variables.tf` file:

```hcl
variable "adaptive_api_key" {
  description = "Adaptive API key"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
}
```

Create a `terraform.tfvars` file (never commit this!):
```hcl
adaptive_api_key = "your-api-key-here"
db_password      = "your-password-here"
```

Or use environment variables:
```bash
export TF_VAR_adaptive_api_key="your-api-key"
export TF_VAR_db_password="your-password"
```

## Your First Resource

### Simple Database Example

Create a `main.tf` file:

```hcl
# PostgreSQL Database Resource
resource "adaptive_resource" "postgres" {
  type = "postgres"
  
  name          = "my-first-database"
  host          = "postgres.example.com"
  port          = "5432"
  username      = "dbuser"
  password      = var.db_password
  database_name = "myapp"
}

# Create an endpoint for database access
resource "adaptive_endpoint" "db_access" {
  name     = "database-access"
  type     = "direct"
  ttl      = "8h"
  resource = adaptive_resource.postgres.name
  
  users = [
    "developer@company.com"
  ]
}
```

### Initialize and Apply

```bash
# Initialize Terraform
terraform init

# Preview changes
terraform plan

# Apply configuration
terraform apply
```

Type `yes` when prompted to confirm.

## Common Workflows

### 1. Basic Workflow

```bash
# 1. Write configuration
vim main.tf

# 2. Format code
terraform fmt

# 3. Validate configuration
terraform validate

# 4. Plan changes
terraform plan

# 5. Apply changes
terraform apply

# 6. View state
terraform show
```

### 2. Working with Multiple Environments

```hcl
# development.tfvars
environment = "dev"
instance_size = "small"

# production.tfvars
environment = "prod"
instance_size = "large"
```

Apply with specific environment:
```bash
terraform apply -var-file="production.tfvars"
```

### 3. Using Workspaces

```bash
# Create workspace
terraform workspace new development

# Switch workspace
terraform workspace select production

# List workspaces
terraform workspace list
```

## Example: Complete Setup

### Directory Structure

```
my-terraform-project/
├── main.tf              # Main resources
├── provider.tf          # Provider configuration
├── variables.tf         # Variable definitions
├── outputs.tf           # Output values
├── terraform.tfvars     # Variable values (gitignored)
└── environments/
    ├── dev.tfvars
    ├── staging.tfvars
    └── prod.tfvars
```

### provider.tf

```hcl
terraform {
  required_version = ">= 0.13"
  
  required_providers {
    adaptive = {
      source  = "adaptive-scale/adaptive"
      version = "~> 0.1.18"
    }
  }
  
  # Remote state (recommended for teams)
  backend "s3" {
    bucket = "my-terraform-state"
    key    = "adaptive/terraform.tfstate"
    region = "us-east-1"
  }
}

provider "adaptive" {
  api_endpoint = var.adaptive_api_endpoint
  api_key      = var.adaptive_api_key
}
```

### main.tf

```hcl
# PostgreSQL Database
resource "adaptive_resource" "postgres" {
  type = "postgres"
  
  name          = "${var.environment}-postgres"
  host          = var.postgres_host
  port          = "5432"
  username      = var.postgres_username
  password      = var.postgres_password
  database_name = var.postgres_database
  
  ssl_mode      = "verify-full"
  tls_root_cert = file("certs/ca-cert.pem")
}

# Developer Group
resource "adaptive_group" "developers" {
  name = "${var.environment}-developers"
  
  members = var.developer_emails
}

# Developer Endpoint
resource "adaptive_endpoint" "db_dev_access" {
  name     = "${var.environment}-db-access"
  type     = "direct"
  ttl      = var.access_ttl
  resource = adaptive_resource.postgres.name
  
  groups = [
    adaptive_group.developers.name
  ]
}
```

### variables.tf

```hcl
variable "environment" {
  description = "Environment name"
  type        = string
}

variable "adaptive_api_endpoint" {
  description = "Adaptive API endpoint"
  type        = string
  default     = "https://api.adaptive.live"
}

variable "adaptive_api_key" {
  description = "Adaptive API key"
  type        = string
  sensitive   = true
}

variable "postgres_host" {
  description = "PostgreSQL host"
  type        = string
}

variable "postgres_username" {
  description = "PostgreSQL username"
  type        = string
}

variable "postgres_password" {
  description = "PostgreSQL password"
  type        = string
  sensitive   = true
}

variable "postgres_database" {
  description = "PostgreSQL database name"
  type        = string
}

variable "developer_emails" {
  description = "List of developer email addresses"
  type        = list(string)
}

variable "access_ttl" {
  description = "Access time-to-live"
  type        = string
  default     = "8h"
}
```

### outputs.tf

```hcl
output "postgres_resource_id" {
  description = "PostgreSQL resource ID"
  value       = adaptive_resource.postgres.id
}

output "endpoint_name" {
  description = "Endpoint name"
  value       = adaptive_endpoint.db_dev_access.name
}
```

### environments/prod.tfvars

```hcl
environment = "production"

postgres_host     = "postgres-prod.company.net"
postgres_username = "app_user"
postgres_database = "production"

developer_emails = [
  "dev1@company.com",
  "dev2@company.com"
]

access_ttl = "6h"
```

## Best Practices

### 1. Security

- ✅ Never commit `terraform.tfvars` or `.tfstate` files
- ✅ Use variables for sensitive data
- ✅ Enable encryption for state files
- ✅ Use remote state for team collaboration
- ✅ Implement least privilege access

### .gitignore

```gitignore
# Local .terraform directories
**/.terraform/*

# .tfstate files
*.tfstate
*.tfstate.*

# Crash log files
crash.log
crash.*.log

# Variable files
*.tfvars
*.tfvars.json

# Override files
override.tf
override.tf.json
*_override.tf
*_override.tf.json

# Sensitive files
*.pem
*.key
*secret*
```

### 2. Code Organization

- ✅ Use modules for reusable components
- ✅ Separate environments with workspaces or directories
- ✅ Use meaningful resource names
- ✅ Add comments for complex configurations
- ✅ Format code with `terraform fmt`

### 3. State Management

```hcl
# Remote state in S3
terraform {
  backend "s3" {
    bucket         = "my-terraform-state"
    key            = "adaptive/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-locks"
  }
}
```

## Troubleshooting

### Common Issues

#### 1. Provider Not Found

```bash
Error: Failed to query available provider packages
```

**Solution:**
```bash
terraform init -upgrade
```

#### 2. State Lock

```bash
Error: Error acquiring the state lock
```

**Solution:**
```bash
# Force unlock (use with caution)
terraform force-unlock <lock-id>
```

#### 3. Invalid Configuration

```bash
Error: Invalid resource type
```

**Solution:**
```bash
# Validate configuration
terraform validate

# Check for syntax errors
terraform fmt -check
```

## Next Steps

1. **Explore Examples**: Browse the [integration examples](index.md#integration-categories)
2. **Read Documentation**: Check specific integration guides:
   - [AWS Integration](aws.md)
   - [Databases](databases.md)
   - [Security & Networking](security-networking.md)
   - [Monitoring](monitoring.md)
3. **Join Community**: Get help and share knowledge
4. **Advanced Topics**: Learn about modules, workspaces, and CI/CD

## Additional Resources

- [Terraform Documentation](https://www.terraform.io/docs)
- [Adaptive Provider Registry](https://registry.terraform.io/providers/adaptive-scale/adaptive/latest/docs)
- [GitHub Repository](https://github.com/adaptive-scale/adaptive-terraform-examples)
- [Adaptive.live](https://adaptive.live)

## Quick Reference

### Essential Commands

```bash
# Initialize
terraform init

# Format code
terraform fmt

# Validate
terraform validate

# Plan changes
terraform plan

# Apply changes
terraform apply

# Destroy resources
terraform destroy

# Show state
terraform show

# List resources
terraform state list

# Import existing resource
terraform import <resource> <id>
```

### Helpful Flags

```bash
# Auto-approve (skip confirmation)
terraform apply -auto-approve

# Specific var file
terraform apply -var-file="prod.tfvars"

# Set variable
terraform apply -var="environment=prod"

# Target specific resource
terraform apply -target=adaptive_resource.postgres

# Detailed logs
TF_LOG=DEBUG terraform apply
```

---

[← Back to Home](index.md)
