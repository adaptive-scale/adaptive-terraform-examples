---
layout: default
title: MongoDB Integration
---

[← Back to Databases](databases.md)

# MongoDB Integration Guide

Complete guide for integrating MongoDB databases with the Adaptive Terraform Provider.

## Table of Contents

- [Basic Configuration](#basic-configuration)
- [MongoDB Atlas](#mongodb-atlas)
- [Authorization & Roles](#authorization--roles)
- [Groups & Endpoints](#groups--endpoints)
- [AWS Secrets Manager](#aws-secrets-manager-integration)
- [Best Practices](#best-practices)
- [Examples](#examples)

---

## Basic Configuration

### Simple MongoDB Connection

```hcl
resource "adaptive_resource" "mongodb" {
  type = "mongodb"
  
  name = "mongodb-production"
  uri  = "mongodb+srv://cluster0.mongodb.net"
}
```

### MongoDB with Credentials

```hcl
resource "adaptive_resource" "mongodb" {
  type = "mongodb"
  
  name        = "mongodb-production"
  uri         = "mongodb+srv://cluster0.mongodb.net"
  username    = var.mongodb_username
  password    = var.mongodb_password
  auth_source = "admin"
}
```

### Self-Hosted MongoDB

```hcl
resource "adaptive_resource" "mongodb" {
  type = "mongodb"
  
  name     = "mongodb-selfhosted"
  uri      = "mongodb://localhost:27017"
  username = "admin"
  password = var.mongodb_password
}
```

---

## MongoDB Atlas

### Atlas Cluster Connection

```hcl
resource "adaptive_resource" "mongodb_atlas" {
  type = "mongodb"
  
  name        = "atlas-production"
  uri         = "mongodb+srv://cluster0.xxxxx.mongodb.net"
  username    = var.atlas_username
  password    = var.atlas_password
  auth_source = "admin"
  
  # Optional: Specify default database
  database_name = "production"
}
```

### Atlas with TLS

```hcl
resource "adaptive_resource" "mongodb_atlas_tls" {
  type = "mongodb"
  
  name        = "atlas-secure"
  uri         = "mongodb+srv://cluster0.xxxxx.mongodb.net"
  username    = var.atlas_username
  password    = var.atlas_password
  auth_source = "admin"
  
  # TLS configuration
  tls         = true
  tls_ca_file = file("ca-certificate.pem")
}
```

---

## Authorization & Roles

### Custom Role Definition

```hcl
resource "adaptive_authorization" "mongodb_developer" {
  name          = "mongodb-developer-role"
  description   = "Developer access with read/write permissions"
  resource_type = "mongodb"
  
  permissions = <<EOF
{
  role: "developerRole",
  privileges: [
    {
      resource: { db: "production", collection: "" },
      actions: [ "find", "insert", "update", "remove" ]
    },
    {
      resource: { db: "staging", collection: "" },
      actions: [ "find", "insert", "update", "remove" ]
    }
  ],
  roles: []
}
EOF
}
```

### Read-Only Role

```hcl
resource "adaptive_authorization" "mongodb_readonly" {
  name          = "mongodb-readonly-role"
  description   = "Read-only access to specific collections"
  resource_type = "mongodb"
  
  permissions = <<EOF
{
  role: "readOnlyRole",
  privileges: [
    {
      resource: { db: "production", collection: "" },
      actions: [ "find" ]
    }
  ],
  roles: []
}
EOF
}
```

### Collection-Specific Access

```hcl
resource "adaptive_authorization" "mongodb_collection_access" {
  name          = "mongodb-collection-role"
  description   = "Access to specific collections"
  resource_type = "mongodb"
  
  permissions = <<EOF
{
  role: "collectionSpecificRole",
  privileges: [
    {
      resource: { db: "production", collection: "users" },
      actions: [ "find", "update", "insert" ]
    },
    {
      resource: { db: "production", collection: "orders" },
      actions: [ "find" ]
    }
  ],
  roles: []
}
EOF
}
```

---

## Groups & Endpoints

### Developer Group with Full Access

```hcl
resource "adaptive_group" "mongodb_developers" {
  name = "mongodb-developers"
  
  members = [
    "dev1@company.com",
    "dev2@company.com"
  ]
  
  endpoints = [
    adaptive_endpoint.mongodb_access.name
  ]
}

resource "adaptive_endpoint" "mongodb_access" {
  name     = "mongodb-developer-access"
  type     = "direct"
  ttl      = "8h"
  resource = adaptive_resource.mongodb.name
  
  authorization = adaptive_authorization.mongodb_developer.name
}
```

### Analyst Group with Read-Only Access

```hcl
resource "adaptive_group" "mongodb_analysts" {
  name = "mongodb-analysts"
  
  members = [
    "analyst1@company.com",
    "analyst2@company.com"
  ]
  
  endpoints = [
    adaptive_endpoint.mongodb_readonly.name
  ]
}

resource "adaptive_endpoint" "mongodb_readonly" {
  name     = "mongodb-readonly-access"
  type     = "direct"
  ttl      = "6h"
  resource = adaptive_resource.mongodb.name
  
  authorization = adaptive_authorization.mongodb_readonly.name
}
```

### Time-Limited Access

```hcl
resource "adaptive_endpoint" "mongodb_temp" {
  name     = "mongodb-temporary-access"
  type     = "direct"
  ttl      = "2h"  # Access expires after 2 hours
  resource = adaptive_resource.mongodb.name
  
  users = [
    "contractor@company.com"
  ]
  
  authorization = adaptive_authorization.mongodb_readonly.name
}
```

---

## AWS Secrets Manager Integration

### MongoDB with AWS Secrets

```hcl
resource "adaptive_resource" "mongodb_secrets" {
  type = "mongodb"
  
  name = "mongodb-secure"
  uri  = "mongodb+srv://cluster0.mongodb.net"
  
  # AWS Secrets Manager integration
  use_aws_secrets       = true
  aws_region            = "us-east-1"
  aws_secret_name       = "mongodb-credentials"
  aws_access_key_id     = var.aws_access_key
  aws_secret_access_key = var.aws_secret_key
}
```

### Secret Format in AWS Secrets Manager

```json
{
  "username": "mongodbuser",
  "password": "supersecurepassword",
  "auth_source": "admin"
}
```

---

## Best Practices

### Connection Security

1. **Always Use TLS**: Enable TLS for all MongoDB connections
```hcl
resource "adaptive_resource" "mongodb" {
  type = "mongodb"
  name = "mongodb-secure"
  uri  = "mongodb+srv://cluster0.mongodb.net"
  tls  = true
}
```

2. **Network Restrictions**: Use IP whitelisting in MongoDB Atlas
3. **Strong Authentication**: Use SCRAM-SHA-256 authentication
4. **Certificate Validation**: Verify server certificates

### Access Control

1. **Principle of Least Privilege**: Grant minimum required permissions
2. **Use Custom Roles**: Define specific roles for different use cases
3. **Short-Lived Credentials**: Use TTLs for temporary access
4. **Audit Logging**: Enable MongoDB audit logs

### Performance

1. **Connection Pooling**: Reuse connections
```hcl
resource "adaptive_resource" "mongodb" {
  type = "mongodb"
  name = "mongodb-pooled"
  uri  = "mongodb+srv://cluster0.mongodb.net/?maxPoolSize=100"
}
```

2. **Read Preferences**: Use read replicas for analytics
3. **Index Optimization**: Ensure proper indexing
4. **Query Optimization**: Monitor slow queries

### High Availability

1. **Replica Sets**: Use MongoDB replica sets
2. **Multi-Region**: Deploy across multiple regions
3. **Automated Backups**: Configure continuous backups
4. **Monitoring**: Set up alerts for connection issues

---

## Examples

### Complete Production Setup

```hcl
# MongoDB Atlas Resource
resource "adaptive_resource" "mongodb_prod" {
  type = "mongodb"
  
  name        = "mongodb-production"
  uri         = "mongodb+srv://prod-cluster.xxxxx.mongodb.net"
  username    = var.mongodb_username
  password    = var.mongodb_password
  auth_source = "admin"
  tls         = true
}

# Developer Role
resource "adaptive_authorization" "dev_role" {
  name          = "developer-role"
  resource_type = "mongodb"
  
  permissions = <<EOF
{
  role: "developerRole",
  privileges: [
    {
      resource: { db: "app_db", collection: "" },
      actions: [ "find", "insert", "update", "remove" ]
    }
  ],
  roles: []
}
EOF
}

# Developers Group
resource "adaptive_group" "developers" {
  name = "backend-developers"
  
  members = [
    "dev1@company.com",
    "dev2@company.com",
    "dev3@company.com"
  ]
  
  endpoints = [
    adaptive_endpoint.dev_access.name
  ]
}

# Developer Endpoint
resource "adaptive_endpoint" "dev_access" {
  name          = "mongodb-dev-access"
  type          = "direct"
  ttl           = "8h"
  resource      = adaptive_resource.mongodb_prod.name
  authorization = adaptive_authorization.dev_role.name
}

# Analytics Role (Read-Only)
resource "adaptive_authorization" "analytics_role" {
  name          = "analytics-role"
  resource_type = "mongodb"
  
  permissions = <<EOF
{
  role: "analyticsRole",
  privileges: [
    {
      resource: { db: "app_db", collection: "" },
      actions: [ "find" ]
    }
  ],
  roles: []
}
EOF
}

# Analytics Group
resource "adaptive_group" "analysts" {
  name = "data-analysts"
  
  members = [
    "analyst1@company.com",
    "analyst2@company.com"
  ]
  
  endpoints = [
    adaptive_endpoint.analytics_access.name
  ]
}

# Analytics Endpoint
resource "adaptive_endpoint" "analytics_access" {
  name          = "mongodb-analytics-access"
  type          = "direct"
  ttl           = "12h"
  resource      = adaptive_resource.mongodb_prod.name
  authorization = adaptive_authorization.analytics_role.name
}
```

### Multi-Environment Setup

```hcl
# Production MongoDB
resource "adaptive_resource" "mongodb_prod" {
  type = "mongodb"
  name = "mongodb-production"
  uri  = "mongodb+srv://prod-cluster.mongodb.net"
  # ... config
}

# Staging MongoDB
resource "adaptive_resource" "mongodb_staging" {
  type = "mongodb"
  name = "mongodb-staging"
  uri  = "mongodb+srv://staging-cluster.mongodb.net"
  # ... config
}

# Development MongoDB
resource "adaptive_resource" "mongodb_dev" {
  type = "mongodb"
  name = "mongodb-development"
  uri  = "mongodb://localhost:27017"
  # ... config
}
```

---

## Connection Examples

### Python (PyMongo)

```python
from pymongo import MongoClient

# Basic connection
client = MongoClient("mongodb+srv://cluster0.mongodb.net",
                    username="user",
                    password="password")

# With TLS
client = MongoClient("mongodb+srv://cluster0.mongodb.net",
                    username="user",
                    password="password",
                    tls=True,
                    tlsCAFile="ca-certificate.pem")

# Use database
db = client['production']
collection = db['users']
```

### Node.js (MongoDB Driver)

```javascript
const { MongoClient } = require('mongodb');

const uri = "mongodb+srv://user:password@cluster0.mongodb.net";
const client = new MongoClient(uri, {
  useNewUrlParser: true,
  useUnifiedTopology: true,
  tls: true
});

async function connect() {
  await client.connect();
  const db = client.db('production');
  const collection = db.collection('users');
}
```

### Go (mongo-go-driver)

```go
import (
    "context"
    "go.mongodb.org/mongo-driver/mongo"
    "go.mongodb.org/mongo-driver/mongo/options"
)

client, err := mongo.Connect(context.TODO(),
    options.Client().ApplyURI("mongodb+srv://cluster0.mongodb.net").
        SetAuth(options.Credential{
            Username: "user",
            Password: "password",
        }))

db := client.Database("production")
collection := db.Collection("users")
```

---

## Troubleshooting

### Connection Issues

1. **Check Network Access**: Verify IP whitelist in MongoDB Atlas
2. **Verify Credentials**: Ensure username/password are correct
3. **Check URI Format**: Validate connection string format
4. **TLS Certificate**: Verify certificate paths and validity

### Permission Errors

1. **Check Role Assignments**: Verify user has correct roles
2. **Database Permissions**: Ensure role has access to database
3. **Collection Access**: Check collection-level permissions
4. **Auth Source**: Verify auth_source is set correctly

---

## Additional Resources

- [MongoDB Documentation](https://docs.mongodb.com/)
- [MongoDB Atlas](https://www.mongodb.com/cloud/atlas)
- [MongoDB Best Practices](https://docs.mongodb.com/manual/administration/production-notes/)
- [GitHub Examples](https://github.com/adaptive-scale/adaptive-terraform-examples/tree/master/mongodb)

---

[← Back to Databases](databases.md) | [← Home](index.md)
