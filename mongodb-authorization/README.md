# MongoDB Authorization Examples

This example demonstrates how to configure MongoDB resources with endpoints that use multi-line authorization configurations containing MongoDB roles.

## Overview

MongoDB authorization in Adaptive endpoints allows you to specify MongoDB roles that define the permissions granted to users accessing the database through the endpoint. The `authorization` field in `adaptive_endpoint` resources accepts JSON-formatted MongoDB role definitions.

## Key Concepts

### MongoDB Roles
MongoDB uses a role-based access control (RBAC) system. Roles define what actions a user can perform on which resources. Common built-in roles include:

- `read` - Read-only access to a database
- `readWrite` - Read and write access to a database
- `dbAdmin` - Administrative access to a database
- `userAdmin` - User management within a database
- `clusterAdmin` - Cluster-wide administrative access
- `backup` - Backup operations
- `readAnyDatabase` - Read access to all databases
- `readWriteAnyDatabase` - Read/write access to all databases

### Multi-line Authorization
The `authorization` field supports multi-line JSON strings that can define:
- Built-in MongoDB roles
- Custom roles with specific privileges
- Database-specific permissions
- Collection-level access control

## Examples Included

### 1. Read-Only Analyst Access
```hcl
authorization = <<EOF
{
  "role": "read",
  "db": "production"
}
EOF
```
Grants read-only access to the production database for analysts.

### 2. Read-Write Developer Access
```hcl
authorization = <<EOF
{
  "role": "readWrite",
  "db": "development"
}
EOF
```
Allows developers to read and write to the development database.

### 3. Custom Data Engineer Role
```hcl
authorization = <<EOF
{
  "role": "dataEngineerRole",
  "db": "analytics",
  "privileges": [
    {
      "resource": {
        "db": "analytics",
        "collection": "user_events"
      },
      "actions": ["find", "insert", "update", "remove"]
    }
  ]
}
EOF
```
Defines a custom role with specific collection-level permissions.

### 4. Database Administrator Access
```hcl
authorization = <<EOF
{
  "role": "dbAdmin",
  "db": "production"
}
EOF
```
Provides administrative access to manage databases.

### 5. Cluster Administrator Access
```hcl
authorization = <<EOF
{
  "role": "clusterAdmin",
  "db": "admin"
}
EOF
```
Grants cluster-wide administrative privileges.

## Usage

```bash
# Initialize Terraform
terraform init

# Validate the configuration
terraform validate

# Plan the deployment
terraform plan

# Apply the configuration
terraform apply
```

## Security Best Practices

1. **Principle of Least Privilege**: Assign the minimum required permissions for each use case
2. **Role Separation**: Use different roles for different teams (analysts vs developers vs admins)
3. **Database Isolation**: Use database-specific roles rather than cluster-wide access
4. **Custom Roles**: Define custom roles for application-specific access patterns
5. **Time-Limited Access**: Use appropriate TTL values to limit session duration

## Custom Role Definition

For complex access patterns, define custom roles with specific privileges:

```hcl
authorization = <<EOF
{
  "role": "customAppRole",
  "db": "production",
  "privileges": [
    {
      "resource": {
        "db": "production",
        "collection": "users"
      },
      "actions": ["find", "update"]
    },
    {
      "resource": {
        "db": "production",
        "collection": "logs"
      },
      "actions": ["find", "insert"]
    }
  ]
}
EOF
```

## MongoDB Role Reference

For more information about MongoDB roles and permissions, refer to:
- [MongoDB Built-in Roles](https://docs.mongodb.com/manual/reference/built-in-roles/)
- [MongoDB Role-Based Access Control](https://docs.mongodb.com/manual/core/authorization/)
- [MongoDB Privilege Actions](https://docs.mongodb.com/manual/reference/privilege-actions/)