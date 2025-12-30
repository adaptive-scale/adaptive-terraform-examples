---
layout: default
title: Database Integrations
---

[← Back to Home](index.md)

# Database Integrations

Comprehensive guide for integrating databases with the Adaptive Terraform Provider.

## Database Categories

- [NoSQL Databases](#nosql-databases)
- [SQL Databases](#sql-databases)
- [Data Warehouses](#data-warehouses)
- [AWS Secrets Manager Integration](#aws-secrets-manager-integration)

---

## NoSQL Databases

### MongoDB

```hcl
resource "adaptive_resource" "mongodb" {
  type = "mongodb"
  
  name = "mongodb-production"
  uri  = "mongodb+srv://cluster0.mongodb.net"
}
```

[Full MongoDB Guide →](mongodb.md)

### MongoDB Atlas

```hcl
resource "adaptive_resource" "mongodb_atlas" {
  type = "mongodb"
  
  name        = "atlas-production"
  uri         = "mongodb+srv://cluster0.xxxxx.mongodb.net"
  username    = var.atlas_username
  password    = var.atlas_password
  auth_source = "admin"
}
```

### CockroachDB

```hcl
resource "adaptive_resource" "cockroachdb" {
  type = "cockroachdb"
  
  name          = "cockroach-prod"
  host          = "free-tier.gcp-us-central1.cockroachlabs.cloud"
  port          = "26257"
  username      = var.crdb_username
  password      = var.crdb_password
  database_name = "defaultdb"
  ssl_mode      = "require"
}
```

### Elasticsearch

```hcl
resource "adaptive_resource" "elasticsearch" {
  type = "elasticsearch"
  
  name     = "elastic-prod"
  endpoint = "https://elasticsearch.example.com:9200"
  username = var.es_username
  password = var.es_password
}
```

### ClickHouse

```hcl
resource "adaptive_resource" "clickhouse" {
  type = "clickhouse"
  
  name          = "clickhouse-analytics"
  host          = "clickhouse.example.com"
  port          = "8123"
  username      = var.ch_username
  password      = var.ch_password
  database_name = "default"
}
```

### YugabyteDB

```hcl
resource "adaptive_resource" "yugabyte" {
  type = "yugabytedb"
  
  name          = "yugabyte-prod"
  host          = "yugabyte.example.com"
  port          = "5433"
  username      = var.yb_username
  password      = var.yb_password
  database_name = "yugabyte"
}
```

---

## SQL Databases

### PostgreSQL

```hcl
resource "adaptive_resource" "postgres" {
  type = "postgres"
  
  name          = "postgres-production"
  host          = "postgres.example.com"
  port          = "5432"
  username      = var.pg_username
  password      = var.pg_password
  database_name = "production"
}
```

[Full PostgreSQL Guide →](postgres.md)

### MySQL

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

[Full MySQL Guide →](mysql.md)

### SQL Server

```hcl
resource "adaptive_resource" "sqlserver" {
  type = "sql_server"
  
  name          = "sqlserver-prod"
  host          = "sqlserver.example.com"
  port          = "1433"
  username      = var.mssql_username
  password      = var.mssql_password
  database_name = "production"
}
```

---

## Data Warehouses

### Snowflake

```hcl
resource "adaptive_resource" "snowflake" {
  type = "snowflake"
  
  name      = "snowflake-analytics"
  account   = "xy12345.us-east-1"
  username  = var.sf_username
  password  = var.sf_password
  warehouse = "COMPUTE_WH"
  database  = "ANALYTICS"
  schema    = "PUBLIC"
}
```

### AWS Redshift

```hcl
resource "adaptive_resource" "redshift" {
  type = "awsredshift"
  
  name          = "redshift-warehouse"
  host          = "redshift-cluster.xxxxx.us-east-1.redshift.amazonaws.com"
  port          = "5439"
  username      = var.rs_username
  password      = var.rs_password
  database_name = "analytics"
}
```

---

## AWS Secrets Manager Integration

Many databases support AWS Secrets Manager for secure credential storage.

### PostgreSQL with AWS Secrets

```hcl
resource "adaptive_resource" "postgres_secure" {
  type = "postgres"
  
  name                   = "postgres-secure"
  use_aws_secrets        = true
  aws_region             = "us-east-1"
  aws_secret_name        = "postgres-credentials"
  aws_access_key_id      = var.aws_access_key
  aws_secret_access_key  = var.aws_secret_key
  
  # Database connection details from secrets
  host                   = "postgres.example.com"
  database_name          = "production"
}
```

### MySQL with AWS Secrets

```hcl
resource "adaptive_resource" "mysql_secure" {
  type = "mysql"
  
  name                   = "mysql-secure"
  use_aws_secrets        = true
  aws_region             = "us-east-1"
  aws_secret_name        = "mysql-credentials"
  aws_access_key_id      = var.aws_access_key
  aws_secret_access_key  = var.aws_secret_key
  
  host                   = "mysql.example.com"
  database_name          = "production"
}
```

### MongoDB with AWS Secrets

```hcl
resource "adaptive_resource" "mongodb_secure" {
  type = "mongodb"
  
  name                   = "mongodb-secure"
  use_aws_secrets        = true
  aws_region             = "us-east-1"
  aws_secret_name        = "mongodb-credentials"
  aws_access_key_id      = var.aws_access_key
  aws_secret_access_key  = var.aws_secret_key
  
  uri                    = "mongodb+srv://cluster0.mongodb.net"
}
```

---

## Common Database Patterns

### Read-Only Access

```hcl
resource "adaptive_endpoint" "readonly_access" {
  name     = "database-readonly"
  type     = "direct"
  ttl      = "8h"
  resource = adaptive_resource.postgres.name
  
  users = [
    "analyst@company.com"
  ]
  
  authorization = adaptive_authorization.readonly.name
}

resource "adaptive_authorization" "readonly" {
  name          = "readonly-role"
  resource_type = "postgres"
  permissions   = jsonencode({
    grants = ["SELECT"]
    schemas = ["public"]
  })
}
```

### Group-Based Access

```hcl
resource "adaptive_group" "developers" {
  name = "database-developers"
  
  members = [
    "dev1@company.com",
    "dev2@company.com"
  ]
  
  endpoints = [
    adaptive_endpoint.db_access.name
  ]
}

resource "adaptive_endpoint" "db_access" {
  name     = "database-dev-access"
  type     = "direct"
  ttl      = "6h"
  resource = adaptive_resource.postgres.name
}
```

### Time-Limited Access

```hcl
resource "adaptive_endpoint" "temp_access" {
  name     = "database-temporary"
  type     = "direct"
  ttl      = "2h"  # Auto-expires after 2 hours
  resource = adaptive_resource.mysql.name
  
  users = [
    "contractor@company.com"
  ]
}
```

---

## Security Best Practices

### Connection Security

1. **Use TLS/SSL**: Always encrypt database connections
2. **Network Isolation**: Use private networks and VPCs
3. **Firewall Rules**: Restrict access by IP address
4. **Strong Passwords**: Use complex passwords or certificates
5. **Rotate Credentials**: Regularly rotate database passwords

### Example: Secure PostgreSQL

```hcl
resource "adaptive_resource" "postgres_secure" {
  type = "postgres"
  
  name          = "postgres-secure"
  host          = "postgres.internal.company.net"
  port          = "5432"
  username      = var.pg_username
  password      = var.pg_password
  database_name = "production"
  
  # Enable SSL/TLS
  tls_root_cert = file("ca-certificate.crt")
  tls_cert_file = file("client-certificate.crt")
  tls_key_file  = file("client-key.key")
  ssl_mode      = "verify-full"
}
```

### Access Control

1. **Principle of Least Privilege**: Grant minimum required permissions
2. **Use Authorizations**: Define role-based access
3. **Audit Logging**: Enable and monitor access logs
4. **MFA**: Implement multi-factor authentication
5. **Session Timeouts**: Use short TTLs for sensitive access

---

## Performance Optimization

### Connection Pooling

```hcl
resource "adaptive_resource" "postgres_pooled" {
  type = "postgres"
  
  name          = "postgres-pooled"
  host          = "postgres.example.com"
  port          = "5432"
  username      = var.pg_username
  password      = var.pg_password
  database_name = "production"
  
  # Connection pool settings
  max_connections     = 100
  min_connections     = 10
  connection_timeout  = 30
}
```

### Read Replicas

```hcl
# Primary database
resource "adaptive_resource" "postgres_primary" {
  type = "postgres"
  name = "postgres-primary"
  host = "postgres-primary.example.com"
  # ... other config
}

# Read replica
resource "adaptive_resource" "postgres_replica" {
  type = "postgres"
  name = "postgres-replica"
  host = "postgres-replica.example.com"
  # ... other config
}

# Read-only endpoint to replica
resource "adaptive_endpoint" "read_replica" {
  name     = "postgres-read-only"
  type     = "direct"
  resource = adaptive_resource.postgres_replica.name
}
```

---

## Quick Reference

### Common Ports

| Database | Default Port |
|----------|--------------|
| PostgreSQL | 5432 |
| MySQL | 3306 |
| MongoDB | 27017 |
| SQL Server | 1433 |
| Redshift | 5439 |
| Snowflake | 443 |
| CockroachDB | 26257 |
| ClickHouse | 8123/9000 |
| Elasticsearch | 9200 |

### Connection String Formats

```bash
# PostgreSQL
postgresql://username:password@host:5432/database

# MySQL
mysql://username:password@host:3306/database

# MongoDB
mongodb+srv://username:password@cluster.mongodb.net/database

# SQL Server
sqlserver://username:password@host:1433?database=dbname
```

---

## Examples Repository

For complete working examples, see:
- [MongoDB Examples](https://github.com/adaptive-scale/adaptive-terraform-examples/tree/master/mongodb)
- [PostgreSQL Examples](https://github.com/adaptive-scale/adaptive-terraform-examples/tree/master/postgres)
- [MySQL Examples](https://github.com/adaptive-scale/adaptive-terraform-examples/tree/master/mysql)
- [All Database Examples](https://github.com/adaptive-scale/adaptive-terraform-examples/)

---

[← Back to Home](index.md) | [Next: MongoDB →](mongodb.md)
