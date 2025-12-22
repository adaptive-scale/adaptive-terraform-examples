# Group and Endpoint Integration Example

This example demonstrates how to manage access control using Adaptive groups and endpoints. It shows different patterns for organizing users and providing secure access to resources.

## Overview

The example creates:

1. **Resources**: PostgreSQL database and Kubernetes cluster
2. **Groups**: Different teams with appropriate access levels
3. **Endpoints**: Various access patterns with different security controls

## Key Concepts

### Groups (`adaptive_group`)
Groups allow you to organize users and associate them with endpoints. A group can have:
- **Members**: List of user emails
- **Endpoints**: List of endpoint names that group members can access

### Endpoints (`adaptive_endpoint`)
Endpoints provide access to resources with specific security controls:
- **Users**: Individual users who can access the endpoint
- **Authorization**: RBAC roles or permissions
- **JIT Access**: Just-In-Time access with approval workflows
- **TTL**: Time-to-live for automatic cleanup
- **Pause Timeout**: Automatic pausing when not in use

## Access Patterns Demonstrated

### 1. Development Access
- Developers get direct access to development resources
- 8-hour TTL for extended development sessions
- Kubernetes access with developer RBAC role

### 2. Analyst Access
- Read-only access to data for analysts
- Shorter 2-hour sessions
- Restricted to specific databases

### 3. Administrative Access
- Full access for platform administrators
- Just-In-Time (JIT) access with approval required
- Very short 30-minute sessions for security

### 4. Emergency Access
- Break-glass access for incident response
- 15-minute sessions with 5-minute pause timeout
- Limited to security and executive team

## Usage

```bash
# Initialize Terraform
terraform init

# Plan the deployment
terraform plan

# Apply the configuration
terraform apply
```

## Security Best Practices

1. **Principle of Least Privilege**: Each group has minimal required access
2. **JIT for High-Risk Access**: Administrative endpoints require approval
3. **Short TTLs**: Sessions expire quickly to reduce risk
4. **Automatic Cleanup**: Pause timeouts prevent abandoned sessions
5. **RBAC Integration**: Use authorization fields for fine-grained permissions

## Managing Group Membership

To add users to groups or endpoints:

```hcl
# Add users to existing group
resource "adaptive_group" "developers" {
  name     = "developers"
  members  = [
    "alice@company.com",
    "bob@company.com",
    "new-developer@company.com"  # Add new member
  ]
  endpoints = [
    adaptive_endpoint.dev_postgres_endpoint.name
  ]
}

# Add individual users to endpoints
resource "adaptive_endpoint" "special_access" {
  name     = "special-project-access"
  resource = adaptive_resource.postgres_db.name
  users    = [
    "contractor@company.com",
    "auditor@external.com"
  ]
}
```

## Monitoring and Auditing

All endpoint access is logged and can be monitored through the Adaptive dashboard. Groups provide centralized user management and access reporting.