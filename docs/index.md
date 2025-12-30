---
layout: default
title: Adaptive Terraform Provider
---

<div style="text-align: center; margin: 2em 0;">
  <img src="https://adaptive.live/adaptive-logo-light.svg" alt="Adaptive.live Logo" style="max-width: 300px; height: auto;" />
</div>

# Adaptive Terraform Provider 

Welcome to the comprehensive documentation for the Adaptive Terraform Provider. This repository contains example configurations for all supported integration types.

## 🚀 Quick Start

1. **Install Terraform** (version 0.13+)
2. **Configure the Adaptive Provider** in your `provider.tf`
3. **Choose an integration** from the examples below
4. **Customize** the configuration for your needs
5. **Apply** using `terraform apply`

[📖 Read the Getting Started Guide →](getting-started.md)

## 📚 Integration Categories

### Cloud Platforms

#### Amazon Web Services (AWS)
- **[AWS Integration](aws.md)** - Basic AWS resource configuration
- **[AWS DocumentDB](aws.md#aws-documentdb)** - MongoDB-compatible database service
- **[AWS Redshift](aws.md#aws-redshift)** - Data warehouse integration
- **[AWS Secrets Manager](aws.md#aws-secrets-manager)** - Secrets management
- **[AWS Keyspaces](aws.md#aws-keyspaces)** - Managed Cassandra service

#### Microsoft Azure
- **[Azure Integration](azure.md)** - Basic Azure resource configuration
- **[Azure Cosmos DB (NoSQL)](azure.md#azure-cosmos-db-nosql)** - Multi-model database service
- **[Azure SQL Server](azure.md#azure-sql-server)** - Managed SQL database

#### Google Cloud Platform (GCP)
- **[GCP Integration](gcp.md)** - Google Cloud Platform resources
- **[Google OAuth](gcp.md#google-oauth-integration)** - Google authentication integration

### Databases

#### NoSQL Databases
- **[MongoDB](mongodb.md)** - MongoDB database integration
- **[MongoDB Atlas](mongodb.md#mongodb-atlas)** - MongoDB cloud service
- **[MongoDB Authorization](mongodb.md#authorization--roles)** - Advanced authorization with multi-line roles
- **[MongoDB + AWS Secrets](mongodb.md#aws-secrets-manager-integration)** - MongoDB with AWS Secrets Manager
- **[CockroachDB](databases.md)** - Distributed SQL database
- **[Elasticsearch](databases.md)** - Search and analytics engine
- **[ClickHouse](databases.md)** - Columnar database
- **[YugabyteDB](databases.md)** - Distributed SQL database

#### SQL Databases
- **[PostgreSQL](postgres.md)** - PostgreSQL database integration
- **[PostgreSQL + AWS Secrets](postgres.md#aws-secrets-manager-integration)** - PostgreSQL with AWS Secrets Manager
- **[MySQL](mysql.md)** - MySQL database integration
- **[MySQL + AWS Secrets](mysql.md#aws-secrets-manager-integration)** - MySQL with AWS Secrets Manager
- **[SQL Server](databases.md)** - Microsoft SQL Server integration
- **[SQL Server + AWS Secrets](databases.md)** - SQL Server with AWS Secrets Manager
- **[Snowflake](databases.md)** - Cloud data warehouse
- **[Snowflake + AWS Secrets](databases.md)** - Snowflake with AWS Secrets Manager

### Networking & Security

#### Network Firewalls
- **[Cisco NGFW](security-networking.md#next-generation-firewalls)** - Cisco Next-Generation Firewall
- **[Fortinet NGFW](security-networking.md#next-generation-firewalls)** - Fortinet Next-Generation Firewall
- **[Palo Alto NGFW](security-networking.md#next-generation-firewalls)** - Palo Alto Next-Generation Firewall

#### Network Infrastructure
- **[Aruba Instant On](security-networking.md#network-infrastructure)** - Aruba networking equipment
- **[Aruba Switch](security-networking.md#network-infrastructure)** - Aruba switch configuration
- **[HPE Switch](security-networking.md#network-infrastructure)** - HPE switch management
- **[ZeroTier](security-networking.md#network-infrastructure)** - Software-defined networking
- **[Kubernetes](security-networking.md#network-infrastructure)** - Container orchestration platform

### Identity & Access Management

- **[Okta](security-networking.md#identity--access-management)** - Identity and access management
- **[OneLogin](security-networking.md#identity--access-management)** - Cloud identity management
- **[JumpCloud](security-networking.md#identity--access-management)** - Directory-as-a-Service platform

### Monitoring & Observability

- **[Datadog](monitoring.md#datadog)** - Monitoring and analytics platform
- **[Coralogix](monitoring.md#coralogix)** - Log analytics and monitoring
- **[Splunk](monitoring.md#splunk)** - Security and observability platform
- **[Syslog](monitoring.md#syslog)** - Syslog server integration

### Communication & Collaboration

- **[Microsoft Teams](https://github.com/adaptive-scale/adaptive-terraform-examples/tree/master/msteams)** - Team collaboration platform
- **[RabbitMQ](https://github.com/adaptive-scale/adaptive-terraform-examples/tree/master/rabbitmq)** - Message broker

### Custom Integrations

- **[Custom SIEM Webhook](monitoring.md#custom-siem-webhook)** - Custom SIEM integration via webhooks
- **[Custom Integration](https://github.com/adaptive-scale/adaptive-terraform-examples/tree/master/customintegration)** - Generic custom integration template

### Special Configurations

- **[Endpoints](../endpoints/)** - Various endpoint creation patterns and configurations
- **[Group-Endpoint Integration](../group-endpoint-integration/)** - Group and endpoint management
- **[Authorization](../authorization/)** - Authorization configuration examples
- **[Adding Users](../adding_users/)** - User management examples
- **[Secrets from File](../secrets-from-file/)** - Load secrets from external files
- **[Services](../services/)** - Service configuration examples
- **[Servers](../servers/)** - Server management examples
- **[Server List](../serverlist/)** - Multiple server configurations
- **[SSH](../ssh/)** - SSH access configuration
- **[RDP Windows](../rdp_windows/)** - Windows RDP access

## 📖 Common Usage Patterns

### Basic Resource Configuration

Every integration follows a similar pattern:

```hcl
resource "adaptive_resource" "example" {
  type = "integration-type"
  name = "resource-name"
  # Integration-specific parameters
}
```

### Creating Groups

```hcl
resource "adaptive_group" "example_group" {
  name     = "group-name"
  members  = [
    "user1@example.com",
    "user2@example.com"
  ]
  endpoints = [
    adaptive_endpoint.example_endpoint.name
  ] # optional, groups can be mapped later
}
```

### Creating Endpoints

```hcl
resource "adaptive_endpoint" "example_endpoint" {
  name        = "endpoint-name"
  resource_id = adaptive_resource.example.id
  # Additional endpoint configuration
}
```

### Integrating with AWS Secrets Manager

Many database integrations support AWS Secrets Manager:

```hcl
resource "adaptive_resource" "db_with_secrets" {
  type                   = "mongodb"
  name                   = "secure-db"
  use_aws_secrets        = true
  aws_region             = "us-east-1"
  aws_secret_name        = "my-db-credentials"
  aws_access_key_id      = var.aws_access_key
  aws_secret_access_key  = var.aws_secret_key
}
```

## 🛠️ Helper Scripts

The repository includes helper scripts in the root directory:

- **`apply.sh`** - Apply Terraform configuration
- **`destroy.sh`** - Destroy created resources

## 📝 File Structure

Each integration directory typically contains:

```
integration-name/
├── provider.tf      # Provider configuration
├── main.tf          # Main resource definitions
├── README.md        # Integration-specific documentation (if available)
└── terraform.tfstate # State file (generated)
```

## 🔧 Configuration Tips

### 1. Provider Configuration

Always configure the Adaptive provider in your `provider.tf`:

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
  # Provider configuration
}
```

### 2. Variable Management

Use variables for sensitive data:

```hcl
variable "db_password" {
  type      = string
  sensitive = true
}
```

### 3. State Management

For production use, configure remote state:

```hcl
terraform {
  backend "s3" {
    bucket = "my-terraform-state"
    key    = "adaptive/terraform.tfstate"
    region = "us-east-1"
  }
}
```

## 🔐 Security Best Practices

1. **Never commit credentials** - Use environment variables or secret managers
2. **Use `.gitignore`** - Exclude `*.tfstate`, `*.tfvars`, and `.terraform/`
3. **Enable encryption** - For state files and sensitive data
4. **Least privilege** - Grant minimal required permissions
5. **Secrets management** - Use AWS Secrets Manager or similar services

## 📊 Example Workflows

### Simple Database Integration

1. Navigate to the integration directory:
   ```bash
   cd mongodb/
   ```

2. Initialize Terraform:
   ```bash
   terraform init
   ```

3. Review the plan:
   ```bash
   terraform plan
   ```

4. Apply the configuration:
   ```bash
   terraform apply
   ```

### Multi-Environment Setup

```hcl
# development.tfvars
environment = "dev"
db_instance_size = "small"

# production.tfvars
environment = "prod"
db_instance_size = "large"
```

Apply with:
```bash
terraform apply -var-file="production.tfvars"
```

## 🤝 Contributing

Contributions are welcome! Please:

1. Fork the repository
2. Create a feature branch
3. Add your integration example
4. Follow existing naming conventions
5. Include a README.md in your integration directory
6. Submit a pull request

## 📚 Additional Resources

- [Terraform Documentation](https://www.terraform.io/docs)
- [Adaptive Provider Documentation](https://registry.terraform.io/providers/adaptive-scale/adaptive/latest/docs)
- [GitHub Repository](https://github.com/adaptive-scale/adaptive-terraform-examples)

## 📄 License

Please refer to the repository's LICENSE file for licensing information.

## 🆘 Support

For issues, questions, or contributions:

- Open an [issue on GitHub](https://github.com/adaptive-scale/adaptive-terraform-examples/issues)
- Check existing examples for similar use cases
- Review the Adaptive Provider documentation

---

**Last Updated**: December 30, 2025

**Repository**: [adaptive-scale/adaptive-terraform-examples](https://github.com/adaptive-scale/adaptive-terraform-examples)
