---
layout: default
title: PostgreSQL Integration
---

[← Back to Databases](databases.md)

# PostgreSQL Integration Guide

Complete guide for integrating PostgreSQL databases with the Adaptive Terraform Provider.

## Table of Contents

- [Basic Configuration](#basic-configuration)
- [SSL/TLS Configuration](#ssltls-configuration)
- [AWS Secrets Manager](#aws-secrets-manager-integration)
- [Authorization & Permissions](#authorization--permissions)
- [Groups & Endpoints](#groups--endpoints)
- [Best Practices](#best-practices)

---

## Basic Configuration

### Simple PostgreSQL Connection

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

### With Connection Pool Settings

```hcl
resource "adaptive_resource" "postgres" {
  type = "postgres"
  
  name          = "postgres-pooled"
  host          = "postgres.example.com"
  port          = "5432"
  username      = var.pg_username
  password      = var.pg_password
  database_name = "production"
  
  # Connection pool configuration
  max_connections = 100
  min_connections = 10
}
```

---

## SSL/TLS Configuration

### Basic TLS

```hcl
resource "adaptive_resource" "postgres_tls" {
  type = "postgres"
  
  name          = "postgres-secure"
  host          = "postgres.example.com"
  port          = "5432"
  username      = var.pg_username
  password      = var.pg_password
  database_name = "production"
  
  # Enable TLS
  ssl_mode      = "require"
  tls_root_cert = file("ca-certificate.crt")
}
```

### Mutual TLS (Client Certificates)

```hcl
resource "adaptive_resource" "postgres_mtls" {
  type = "postgres"
  
  name          = "postgres-mtls"
  host          = "postgres.example.com"
  port          = "5432"
  username      = var.pg_username
  password      = var.pg_password
  database_name = "production"
  
  # Mutual TLS configuration
  ssl_mode      = "verify-full"
  tls_root_cert = file("ca-certificate.crt")
  tls_cert_file = file("client-certificate.crt")
  tls_key_file  = file("client-key.key")
}
```

### SSL Mode Options

| Mode | Description |
|------|-------------|
| `disable` | No SSL connection |
| `require` | SSL required, no certificate verification |
| `verify-ca` | SSL required, verify server certificate |
| `verify-full` | SSL required, verify server certificate and hostname |

---

## AWS Secrets Manager Integration

### PostgreSQL with AWS Secrets

```hcl
resource "adaptive_resource" "postgres_secrets" {
  type = "postgres"
  
  name = "postgres-secure"
  host = "postgres.example.com"
  port = "5432"
  database_name = "production"
  
  # AWS Secrets Manager integration
  use_aws_secrets       = true
  aws_region            = "us-east-1"
  aws_secret_name       = "postgres-credentials"
  aws_access_key_id     = var.aws_access_key
  aws_secret_access_key = var.aws_secret_key
}
```

### Secret Format

```json
{
  "username": "dbuser",
  "password": "supersecurepassword",
  "engine": "postgres",
  "host": "postgres.example.com",
  "port": 5432,
  "dbname": "production"
}
```

---

## Authorization & Permissions

### Read-Only Authorization

```hcl
resource "adaptive_authorization" "postgres_readonly" {
  name          = "postgres-readonly"
  description   = "Read-only access to production database"
  resource_type = "postgres"
  
  permissions = jsonencode({
    grants  = ["SELECT"]
    schemas = ["public"]
    tables  = ["*"]
  })
}
```

### Developer Authorization

```hcl
resource "adaptive_authorization" "postgres_developer" {
  name          = "postgres-developer"
  description   = "Developer access with CRUD permissions"
  resource_type = "postgres"
  
  permissions = jsonencode({
    grants = [
      "SELECT",
      "INSERT",
      "UPDATE",
      "DELETE"
    ]
    schemas = ["public", "app"]
    tables  = ["*"]
  })
}
```

### Schema-Specific Access

```hcl
resource "adaptive_authorization" "postgres_schema_access" {
  name          = "postgres-analytics-access"
  description   = "Access to analytics schema only"
  resource_type = "postgres"
  
  permissions = jsonencode({
    grants  = ["SELECT", "INSERT"]
    schemas = ["analytics"]
    tables  = ["events", "metrics"]
  })
}
```

---

## Groups & Endpoints

### Developer Group

```hcl
resource "adaptive_group" "postgres_developers" {
  name = "postgres-developers"
  
  members = [
    "dev1@company.com",
    "dev2@company.com"
  ]
  
  endpoints = [
    adaptive_endpoint.postgres_dev_access.name
  ]
}

resource "adaptive_endpoint" "postgres_dev_access" {
  name          = "postgres-developer-access"
  type          = "direct"
  ttl           = "8h"
  resource      = adaptive_resource.postgres.name
  authorization = adaptive_authorization.postgres_developer.name
}
```

### Analyst Group (Read-Only)

```hcl
resource "adaptive_group" "postgres_analysts" {
  name = "data-analysts"
  
  members = [
    "analyst1@company.com",
    "analyst2@company.com"
  ]
  
  endpoints = [
    adaptive_endpoint.postgres_readonly_access.name
  ]
}

resource "adaptive_endpoint" "postgres_readonly_access" {
  name          = "postgres-readonly-access"
  type          = "direct"
  ttl           = "12h"
  resource      = adaptive_resource.postgres.name
  authorization = adaptive_authorization.postgres_readonly.name
}
```

---

## Best Practices

### Security

1. **Always Use SSL/TLS**
```hcl
ssl_mode = "verify-full"
```

2. **Use Strong Passwords**: Minimum 16 characters, mixed case, numbers, symbols

3. **Limit Connections**: Set appropriate connection limits
```hcl
max_connections = 100
```

4. **Network Isolation**: Use private networks/VPCs

5. **Regular Audits**: Enable PostgreSQL audit logging
```sql
ALTER SYSTEM SET log_connections = 'on';
ALTER SYSTEM SET log_disconnections = 'on';
```

### Performance

1. **Connection Pooling**: Use PgBouncer or connection pooling
```hcl
min_connections = 10
max_connections = 100
```

2. **Index Optimization**: Create appropriate indexes
```sql
CREATE INDEX idx_users_email ON users(email);
```

3. **Query Optimization**: Use EXPLAIN ANALYZE
```sql
EXPLAIN ANALYZE SELECT * FROM users WHERE email = 'user@example.com';
```

4. **Vacuum Regularly**: Schedule VACUUM operations
```sql
VACUUM ANALYZE;
```

### High Availability

1. **Replication**: Set up streaming replication
2. **Backups**: Configure automated backups
3. **Monitoring**: Use pg_stat_statements
4. **Failover**: Implement automatic failover

---

## Complete Production Example

```hcl
# PostgreSQL Production Resource
resource "adaptive_resource" "postgres_prod" {
  type = "postgres"
  
  name          = "postgres-production"
  host          = "postgres-primary.internal.company.net"
  port          = "5432"
  database_name = "production"
  
  # Use AWS Secrets Manager
  use_aws_secrets       = true
  aws_region            = "us-east-1"
  aws_secret_name       = "postgres-prod-credentials"
  aws_access_key_id     = var.aws_access_key
  aws_secret_access_key = var.aws_secret_key
  
  # SSL Configuration
  ssl_mode      = "verify-full"
  tls_root_cert = file("${path.module}/certs/ca-cert.pem")
  tls_cert_file = file("${path.module}/certs/client-cert.pem")
  tls_key_file  = file("${path.module}/certs/client-key.pem")
  
  # Connection pool
  max_connections = 100
  min_connections = 20
}

# Read Replica for Analytics
resource "adaptive_resource" "postgres_replica" {
  type = "postgres"
  
  name          = "postgres-read-replica"
  host          = "postgres-replica.internal.company.net"
  port          = "5432"
  database_name = "production"
  
  use_aws_secrets       = true
  aws_region            = "us-east-1"
  aws_secret_name       = "postgres-replica-credentials"
  aws_access_key_id     = var.aws_access_key
  aws_secret_access_key = var.aws_secret_key
  
  ssl_mode = "verify-full"
}

# Developer Authorization
resource "adaptive_authorization" "dev_role" {
  name          = "developer-role"
  resource_type = "postgres"
  
  permissions = jsonencode({
    grants  = ["SELECT", "INSERT", "UPDATE", "DELETE"]
    schemas = ["public", "app"]
    tables  = ["*"]
  })
}

# Analyst Authorization
resource "adaptive_authorization" "analyst_role" {
  name          = "analyst-role"
  resource_type = "postgres"
  
  permissions = jsonencode({
    grants  = ["SELECT"]
    schemas = ["public", "analytics"]
    tables  = ["*"]
  })
}

# Developer Group
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

# Developer Endpoint
resource "adaptive_endpoint" "dev_access" {
  name          = "postgres-dev-access"
  type          = "direct"
  ttl           = "8h"
  resource      = adaptive_resource.postgres_prod.name
  authorization = adaptive_authorization.dev_role.name
}

# Analyst Group (Read Replica)
resource "adaptive_group" "analysts" {
  name = "data-analysts"
  
  members = [
    "analyst1@company.com",
    "analyst2@company.com"
  ]
  
  endpoints = [
    adaptive_endpoint.analyst_access.name
  ]
}

# Analyst Endpoint (using replica)
resource "adaptive_endpoint" "analyst_access" {
  name          = "postgres-analyst-access"
  type          = "direct"
  ttl           = "12h"
  resource      = adaptive_resource.postgres_replica.name
  authorization = adaptive_authorization.analyst_role.name
}
```

---

## Connection Examples

### Python (psycopg2)

```python
import psycopg2

# Basic connection
conn = psycopg2.connect(
    host="postgres.example.com",
    port=5432,
    database="production",
    user="dbuser",
    password="password"
)

# With SSL
conn = psycopg2.connect(
    host="postgres.example.com",
    port=5432,
    database="production",
    user="dbuser",
    password="password",
    sslmode="verify-full",
    sslrootcert="ca-cert.pem"
)
```

### Node.js (pg)

```javascript
const { Client } = require('pg');

const client = new Client({
  host: 'postgres.example.com',
  port: 5432,
  database: 'production',
  user: 'dbuser',
  password: 'password',
  ssl: {
    rejectUnauthorized: true,
    ca: fs.readFileSync('ca-cert.pem').toString()
  }
});

await client.connect();
```

### Go (pgx)

```go
import (
    "context"
    "github.com/jackc/pgx/v4"
)

conn, err := pgx.Connect(context.Background(),
    "postgres://dbuser:password@postgres.example.com:5432/production?sslmode=verify-full")
```

---

## Troubleshooting

### Connection Issues

1. **Check Firewall**: Verify port 5432 is open
2. **Verify Credentials**: Test with psql client
3. **Check pg_hba.conf**: Ensure client authentication is configured
4. **SSL Issues**: Verify certificate paths and validity

### Performance Issues

1. **Check Connections**: Monitor active connections
```sql
SELECT count(*) FROM pg_stat_activity;
```

2. **Slow Queries**: Identify slow queries
```sql
SELECT query, mean_exec_time
FROM pg_stat_statements
ORDER BY mean_exec_time DESC
LIMIT 10;
```

---

## Additional Resources

- [PostgreSQL Documentation](https://www.postgresql.org/docs/)
- [PostgreSQL Security](https://www.postgresql.org/docs/current/auth-pg-hba-conf.html)
- [GitHub Examples](https://github.com/adaptive-scale/adaptive-terraform-examples/tree/master/postgres)

---

[← Back to Databases](databases.md) | [← Home](index.md)
