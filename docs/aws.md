---
layout: default
title: Cloud Platforms - AWS
---

[← Back to Home](index.md)

# Amazon Web Services (AWS) Integrations

Comprehensive guide for integrating AWS services with the Adaptive Terraform Provider.

## Available AWS Integrations

- [AWS Basic Integration](#aws-basic-integration)
- [AWS DocumentDB](#aws-documentdb)
- [AWS Redshift](#aws-redshift)
- [AWS Secrets Manager](#aws-secrets-manager)
- [AWS Keyspaces](#aws-keyspaces)

---

## AWS Basic Integration

Basic AWS resource configuration for general AWS services.

### Configuration

```hcl
resource "adaptive_resource" "aws" {
  type = "aws"

  name              = "aws-production"
  region_name       = "us-east-1"
  access_key_id     = var.aws_access_key
  secret_access_key = var.aws_secret_key
}
```

### Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `name` | string | Yes | Unique name for this AWS resource |
| `region_name` | string | Yes | AWS region (e.g., us-east-1, eu-west-1) |
| `access_key_id` | string | Yes | AWS access key ID |
| `secret_access_key` | string | Yes | AWS secret access key |

### Example with Endpoint

```hcl
resource "adaptive_resource" "aws" {
  type              = "aws"
  name              = "aws-production"
  region_name       = "us-east-1"
  access_key_id     = var.aws_access_key
  secret_access_key = var.aws_secret_key
}

resource "adaptive_endpoint" "aws_console" {
  name     = "aws-console-access"
  type     = "direct"
  ttl      = "8h"
  resource = adaptive_resource.aws.name

  users = [
    "engineer@company.com"
  ]
}
```

---

## AWS DocumentDB

MongoDB-compatible database service on AWS.

### Configuration

```hcl
resource "adaptive_resource" "documentdb" {
  type = "awsdocumentdb"

  name          = "documentdb-prod"
  host          = "docdb-cluster.cluster-xxxxx.us-east-1.docdb.amazonaws.com"
  port          = "27017"
  username      = var.docdb_username
  password      = var.docdb_password
  database_name = "production"
  tls_ca_cert   = file("rds-combined-ca-bundle.pem")
}
```

### Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `name` | string | Yes | Resource name |
| `host` | string | Yes | DocumentDB cluster endpoint |
| `port` | string | Yes | Port (default: 27017) |
| `username` | string | Yes | Database username |
| `password` | string | Yes | Database password |
| `database_name` | string | Yes | Database name |
| `tls_ca_cert` | string | No | TLS CA certificate |

---

## AWS Redshift

Data warehouse integration for AWS Redshift.

### Configuration

```hcl
resource "adaptive_resource" "redshift" {
  type = "awsredshift"

  name          = "redshift-analytics"
  host          = "redshift-cluster.xxxxx.us-east-1.redshift.amazonaws.com"
  port          = "5439"
  username      = var.redshift_username
  password      = var.redshift_password
  database_name = "analytics"
}
```

### Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `name` | string | Yes | Resource name |
| `host` | string | Yes | Redshift cluster endpoint |
| `port` | string | Yes | Port (default: 5439) |
| `username` | string | Yes | Database username |
| `password` | string | Yes | Database password |
| `database_name` | string | Yes | Database name |

---

## AWS Secrets Manager

Secrets management integration for secure credential storage.

### Configuration

```hcl
resource "adaptive_resource" "secrets_manager" {
  type = "awssecretsmanager"

  name              = "secrets-prod"
  region_name       = "us-east-1"
  access_key_id     = var.aws_access_key
  secret_access_key = var.aws_secret_key
}
```

### Using with Other Resources

```hcl
resource "adaptive_resource" "postgres_with_secrets" {
  type                   = "postgres"
  name                   = "postgres-secure"
  use_aws_secrets        = true
  aws_region             = "us-east-1"
  aws_secret_name        = "postgres-credentials"
  aws_access_key_id      = var.aws_access_key
  aws_secret_access_key  = var.aws_secret_key
}
```

---

## AWS Keyspaces

Managed Apache Cassandra-compatible database service.

### Configuration

```hcl
resource "adaptive_resource" "keyspaces" {
  type = "keyspaces"

  name              = "keyspaces-prod"
  region_name       = "us-east-1"
  access_key_id     = var.aws_access_key
  secret_access_key = var.aws_secret_key
  keyspace_name     = "production"
}
```

---

## Best Practices

### Security

1. **Use IAM Roles**: Prefer IAM roles over access keys when possible
2. **Rotate Credentials**: Regularly rotate access keys and passwords
3. **Least Privilege**: Grant minimum required permissions
4. **Enable MFA**: Use multi-factor authentication for sensitive operations
5. **Use Secrets Manager**: Store credentials in AWS Secrets Manager

### Performance

1. **Choose Correct Region**: Deploy in the region closest to your users
2. **Use VPC Endpoints**: For private connectivity to AWS services
3. **Enable Encryption**: Use encryption at rest and in transit
4. **Monitor Usage**: Set up CloudWatch alarms for resource usage

### Cost Optimization

1. **Right-Size Resources**: Choose appropriate instance sizes
2. **Use Reserved Instances**: For predictable workloads
3. **Enable Auto-Scaling**: Scale resources based on demand
4. **Clean Up Unused Resources**: Regularly audit and remove unused resources

## Examples Repository

For complete working examples, see:
- [AWS Integration](https://github.com/adaptive-scale/adaptive-terraform-examples/tree/master/aws)
- [AWS DocumentDB](https://github.com/adaptive-scale/adaptive-terraform-examples/tree/master/awsdocumentdb)
- [AWS Redshift](https://github.com/adaptive-scale/adaptive-terraform-examples/tree/master/awsredshift)
- [AWS Secrets Manager](https://github.com/adaptive-scale/adaptive-terraform-examples/tree/master/awssecretsmanager)
- [AWS Keyspaces](https://github.com/adaptive-scale/adaptive-terraform-examples/tree/master/keyspaces)

## Additional Resources

- [AWS Terraform Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [AWS Best Practices](https://aws.amazon.com/architecture/well-architected/)
- [Adaptive Provider Documentation](https://registry.terraform.io/providers/adaptive-scale/adaptive/latest/docs)

---

[← Back to Home](index.md) | [Next: Azure →](azure.md)
