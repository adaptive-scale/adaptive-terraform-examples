---
layout: default
title: Adaptive Terraform Provider Examples
---

# Adaptive Terraform Provider Examples

Welcome to the comprehensive documentation for the Adaptive Terraform Provider. This repository contains example configurations for all supported integration types.

## 🚀 Quick Start

1. **Install Terraform** (version 0.13+)
2. **Configure the Adaptive Provider** in your `provider.tf`
3. **Choose an integration** from the examples below
4. **Customize** the configuration for your needs
5. **Apply** using `terraform apply`

## 📚 Integration Categories

### Cloud Platforms

#### Amazon Web Services (AWS)
- **[AWS Integration](../aws/)** - Basic AWS resource configuration
- **[AWS DocumentDB](../awsdocumentdb/)** - MongoDB-compatible database service
- **[AWS Redshift](../awsredshift/)** - Data warehouse integration
- **[AWS Secrets Manager](../awssecretsmanager/)** - Secrets management
- **[AWS Keyspaces](../keyspaces/)** - Managed Cassandra service

#### Microsoft Azure
- **[Azure Integration](../azure/)** - Basic Azure resource configuration
- **[Azure Cosmos DB (NoSQL)](../azurecosmosnosql/)** - Multi-model database service
- **[Azure SQL Server](../azuresqlserver/)** - Managed SQL database

#### Google Cloud Platform (GCP)
- **[GCP Integration](../gcp/)** - Google Cloud Platform resources
- **[Google OAuth](../google/)** - Google authentication integration

### Databases

#### NoSQL Databases
- **[MongoDB](../mongodb/)** - MongoDB database integration
- **[MongoDB Atlas](../mongodb_atlas/)** - MongoDB cloud service
- **[MongoDB Authorization](../mongodb-authorization/)** - Advanced authorization with multi-line roles
- **[MongoDB + AWS Secrets](../mongodb_aws_secrets_manager/)** - MongoDB with AWS Secrets Manager
- **[CockroachDB](../cockroachdb/)** - Distributed SQL database
- **[Elasticsearch](../elasticsearch/)** - Search and analytics engine
- **[ClickHouse](../clickhouse/)** - Columnar database
- **[YugabyteDB](../yugabytedb/)** - Distributed SQL database

#### SQL Databases
- **[PostgreSQL](../postgres/)** - PostgreSQL database integration
- **[PostgreSQL + AWS Secrets](../postgres_aws_secrets_manager/)** - PostgreSQL with AWS Secrets Manager
- **[MySQL](../mysql/)** - MySQL database integration
- **[MySQL + AWS Secrets](../mysql_aws_secrets_manager/)** - MySQL with AWS Secrets Manager
- **[SQL Server](../sql_server/)** - Microsoft SQL Server integration
- **[SQL Server + AWS Secrets](../sqlserver_aws_secrets_manager/)** - SQL Server with AWS Secrets Manager
- **[Snowflake](../snowflake/)** - Cloud data warehouse
- **[Snowflake + AWS Secrets](../snowflake_aws_secrets_manager/)** - Snowflake with AWS Secrets Manager

### Networking & Security

#### Network Firewalls
- **[Cisco NGFW](../cisco_ngfw/)** - Cisco Next-Generation Firewall
- **[Fortinet NGFW](../fortinet_ngfw/)** - Fortinet Next-Generation Firewall
- **[Palo Alto NGFW](../paloalto_ngfw/)** - Palo Alto Next-Generation Firewall

#### Network Infrastructure
- **[Aruba Instant On](../aruba_instant_on/)** - Aruba networking equipment
- **[Aruba Switch](../aruba_sw/)** - Aruba switch configuration
- **[HPE Switch](../hpe_switch/)** - HPE switch management
- **[ZeroTier](../zerotier/)** - Software-defined networking
- **[Kubernetes](../kubernetes/)** - Container orchestration platform

### Identity & Access Management

- **[Okta](../okta/)** - Identity and access management
- **[OneLogin](../onelogin/)** - Cloud identity management
- **[JumpCloud](../jumpcloud/)** - Directory-as-a-Service platform

### Monitoring & Observability

- **[Datadog](../datadog/)** - Monitoring and analytics platform
- **[Coralogix](../coralogix/)** - Log analytics and monitoring
- **[Splunk](../splunk/)** - Security and observability platform
- **[Syslog](../syslog/)** - Syslog server integration

### Communication & Collaboration

- **[Microsoft Teams](../msteams/)** - Team collaboration platform
- **[RabbitMQ](../rabbitmq/)** - Message broker

### Custom Integrations

- **[Custom SIEM Webhook](../custom_siem_webhook/)** - Custom SIEM integration via webhooks
- **[Custom Integration](../customintegration/)** - Generic custom integration template

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
  ]
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
      source = "adaptive-scale/adaptive"
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
