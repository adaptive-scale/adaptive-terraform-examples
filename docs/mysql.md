---
layout: default
title: MySQL Integration
---

[← Back to Databases](databases.md)

# MySQL Integration Guide

Complete guide for integrating MySQL databases with the Adaptive Terraform Provider.

## Table of Contents

- [Basic Configuration](#basic-configuration)
- [SSL/TLS Configuration](#ssltls-configuration)
- [AWS Secrets Manager](#aws-secrets-manager-integration)
- [Authorization & Permissions](#authorization--permissions)
- [Groups & Endpoints](#groups--endpoints)
- [Best Practices](#best-practices)

---

## Basic Configuration

### Simple MySQL Connection

```hcl
resource "adaptive_resource" "mysql" {
  type = "mysql"
  
  name          = "mysql-production"
  host          = "mysql.example.com"
  port          = "3306"
  username      = var.mysql_username
  password      = var.mysql_password
  database_name = "production"
}
```

### With Character Set

```hcl
resource "adaptive_resource" "mysql" {
  type = "mysql"
  
  name          = "mysql-utf8"
  host          = "mysql.example.com"
  port          = "3306"
  username      = var.mysql_username
  password      = var.mysql_password
  database_name = "production"
  charset       = "utf8mb4"
  collation     = "utf8mb4_unicode_ci"
}
```

---

## SSL/TLS Configuration

### Basic TLS

```hcl
resource "adaptive_resource" "mysql_tls" {
  type = "mysql"
  
  name          = "mysql-secure"
  host          = "mysql.example.com"
  port          = "3306"
  username      = var.mysql_username
  password      = var.mysql_password
  database_name = "production"
  
  # Enable TLS
  tls         = true
  tls_ca_cert = file("ca-certificate.pem")
}
```

### Mutual TLS

```hcl
resource "adaptive_resource" "mysql_mtls" {
  type = "mysql"
  
  name          = "mysql-mtls"
  host          = "mysql.example.com"
  port          = "3306"
  username      = var.mysql_username
  password      = var.mysql_password
  database_name = "production"
  
  # Mutual TLS
  tls           = true
  tls_ca_cert   = file("ca-certificate.pem")
  tls_cert_file = file("client-certificate.pem")
  tls_key_file  = file("client-key.pem")
}
```

---

## AWS Secrets Manager Integration

```hcl
resource "adaptive_resource" "mysql_secrets" {
  type = "mysql"
  
  name = "mysql-secure"
  host = "mysql.example.com"
  port = "3306"
  database_name = "production"
  
  # AWS Secrets Manager
  use_aws_secrets       = true
  aws_region            = "us-east-1"
  aws_secret_name       = "mysql-credentials"
  aws_access_key_id     = var.aws_access_key
  aws_secret_access_key = var.aws_secret_key
}
```

---

## Authorization & Permissions

### Read-Only Authorization

```hcl
resource "adaptive_authorization" "mysql_readonly" {
  name          = "mysql-readonly"
  description   = "Read-only access"
  resource_type = "mysql"
  
  permissions = jsonencode({
    grants    = ["SELECT"]
    databases = ["production"]
    tables    = ["*"]
  })
}
```

### Developer Authorization

```hcl
resource "adaptive_authorization" "mysql_developer" {
  name          = "mysql-developer"
  description   = "Developer CRUD access"
  resource_type = "mysql"
  
  permissions = jsonencode({
    grants = [
      "SELECT",
      "INSERT",
      "UPDATE",
      "DELETE"
    ]
    databases = ["production", "staging"]
    tables    = ["*"]
  })
}
```

---

## Groups & Endpoints

### Developer Group

```hcl
resource "adaptive_group" "mysql_developers" {
  name = "mysql-developers"
  
  members = [
    "dev1@company.com",
    "dev2@company.com"
  ]
  
  endpoints = [
    adaptive_endpoint.mysql_dev_access.name
  ]
}

resource "adaptive_endpoint" "mysql_dev_access" {
  name          = "mysql-developer-access"
  type          = "direct"
  ttl           = "8h"
  resource      = adaptive_resource.mysql.name
  authorization = adaptive_authorization.mysql_developer.name
}
```

---

## Best Practices

### Security

1. **Use SSL/TLS**: Always encrypt connections
2. **Strong Passwords**: Minimum 16 characters
3. **Limit Privileges**: Grant only necessary permissions
4. **Network Security**: Use private networks
5. **Regular Updates**: Keep MySQL updated

### Performance

1. **Connection Pooling**: Reuse database connections
2. **Query Optimization**: Use EXPLAIN to optimize queries
3. **Indexing**: Create appropriate indexes
4. **InnoDB Buffer Pool**: Tune buffer pool size

### High Availability

1. **Replication**: Set up MySQL replication
2. **Automated Backups**: Schedule regular backups
3. **Monitoring**: Monitor queries and connections
4. **Failover**: Implement automatic failover

---

## Complete Production Example

```hcl
resource "adaptive_resource" "mysql_prod" {
  type = "mysql"
  
  name          = "mysql-production"
  host          = "mysql-primary.internal.company.net"
  port          = "3306"
  database_name = "production"
  
  use_aws_secrets       = true
  aws_region            = "us-east-1"
  aws_secret_name       = "mysql-prod-credentials"
  aws_access_key_id     = var.aws_access_key
  aws_secret_access_key = var.aws_secret_key
  
  # SSL
  tls         = true
  tls_ca_cert = file("certs/ca-cert.pem")
  
  # Character set
  charset   = "utf8mb4"
  collation = "utf8mb4_unicode_ci"
}

resource "adaptive_authorization" "dev_role" {
  name          = "developer-role"
  resource_type = "mysql"
  
  permissions = jsonencode({
    grants    = ["SELECT", "INSERT", "UPDATE", "DELETE"]
    databases = ["production"]
    tables    = ["*"]
  })
}

resource "adaptive_group" "developers" {
  name = "backend-developers"
  
  members = [
    "dev1@company.com",
    "dev2@company.com"
  ]
  
  endpoints = [
    adaptive_endpoint.dev_access.name
  ]
}

resource "adaptive_endpoint" "dev_access" {
  name          = "mysql-dev-access"
  type          = "direct"
  ttl           = "8h"
  resource      = adaptive_resource.mysql_prod.name
  authorization = adaptive_authorization.dev_role.name
}
```

---

## Connection Examples

### Python (mysql-connector)

```python
import mysql.connector

conn = mysql.connector.connect(
    host="mysql.example.com",
    port=3306,
    database="production",
    user="dbuser",
    password="password",
    ssl_ca="ca-cert.pem"
)
```

### Node.js (mysql2)

```javascript
const mysql = require('mysql2');

const connection = mysql.createConnection({
  host: 'mysql.example.com',
  port: 3306,
  database: 'production',
  user: 'dbuser',
  password: 'password',
  ssl: {
    ca: fs.readFileSync('ca-cert.pem')
  }
});
```

---

[← Back to Databases](databases.md) | [← Home](index.md)
