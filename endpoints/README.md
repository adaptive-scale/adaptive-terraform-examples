# Adaptive Endpoints Example

This example demonstrates various patterns for creating endpoints in the Adaptive Terraform provider. Endpoints provide controlled access to resources with different authorization levels, time-to-live settings, and approval workflows.

## Overview

Endpoints in Adaptive allow you to:
- Grant temporary or permanent access to resources
- Apply different authorization levels (read-only, developer, admin, etc.)
- Require just-in-time (JIT) approvals for sensitive access
- Set time-to-live (TTL) limits on access duration
- Associate users or groups with specific access patterns

## Prerequisites

- Adaptive Terraform provider configured
- Access to create resources and endpoints in your Adaptive environment

## Quick Start

1. **Initialize Terraform**:
   ```bash
   terraform init
   ```

2. **Review the plan**:
   ```bash
   terraform plan
   ```

3. **Apply the configuration**:
   ```bash
   terraform apply
   ```

## Endpoint Types Demonstrated

### 1. Basic Direct Access
```terraform
resource "adaptive_endpoint" "basic_direct" {
  name     = "basic-postgres-access"
  type     = "direct"
  ttl      = "1d"
  resource = adaptive_resource.postgres_db.name

  users = [
    "developer@company.com"
  ]
}
```

### 2. Authorization-Based Access
```terraform
resource "adaptive_endpoint" "readonly_access" {
  name          = "readonly-postgres"
  type          = "direct"
  ttl           = "1d"
  resource      = adaptive_resource.postgres_db.name
  authorization = "readonly"

  users = [
    "analyst@company.com"
  ]
}
```

### 3. Just-in-Time (JIT) Approval
```terraform
resource "adaptive_endpoint" "jit_production" {
  name          = "jit-prod-access"
  type          = "direct"
  ttl           = "6h"
  resource      = adaptive_resource.postgres_db.name
  authorization = "production-access"

  is_jit_enabled = true
  jit_approvers  = [
    "security@company.com"
  ]

  users = [
    "developer@company.com"
  ]
}
```

### 4. Emergency Access
```terraform
resource "adaptive_endpoint" "emergency_access" {
  name          = "emergency-access"
  type          = "direct"
  ttl           = "3h"
  resource      = adaptive_resource.postgres_db.name
  authorization = "emergency-admin"

  users = [
    "security@company.com"
  ]

  pause_timeout = "15m"
}
```

## Configuration Options

### Time-to-Live (TTL) Values
Supported TTL values:
- `3h`, `6h`, `1d`, `3d`, `7d`, `30d`, `60d`, `90d`, `180d`, `360d`

### Endpoint Types
- `direct` - Direct access to the resource

### Authorization Levels
Common authorization values (resource-specific):
- `readonly` - Read-only access
- `developer` - Development-level access
- `admin` - Full administrative access
- Custom roles defined in your Adaptive environment

### JIT Approval Settings
- `is_jit_enabled` - Enable just-in-time approval workflow
- `jit_approvers` - List of users who can approve access requests

### Emergency Access
- `pause_timeout` - Grace period before access is revoked (e.g., "15m")

## Advanced Patterns

### Environment-Based Configuration
```terraform
resource "adaptive_endpoint" "environment_based" {
  name     = "env-based-access"
  type     = "direct"
  ttl      = terraform.workspace == "production" ? "6h" : "1d"
  resource = adaptive_resource.postgres_db.name

  users = terraform.workspace == "production" ? [
    "prod-support@company.com"
  ] : [
    "developer@company.com"
  ]
}
```

### Multiple Resources
While this example shows single-resource endpoints, you can create multiple endpoints for different resources and manage access patterns accordingly.

## Security Considerations

1. **Principle of Least Privilege**: Use the most restrictive authorization level needed
2. **Short TTLs**: Prefer shorter time-to-live values for sensitive resources
3. **JIT Approval**: Enable for production or sensitive environments
4. **Regular Review**: Periodically audit endpoint access and usage
5. **Emergency Access**: Limit to essential personnel only

## Integration with Groups

For managing access at scale, consider using Adaptive groups:

```terraform
resource "adaptive_group" "developers" {
  name     = "developers"
  members  = ["alice@company.com", "bob@company.com"]
  endpoints = [
    adaptive_endpoint.developer_access.name
  ]
}
```

See the `group-endpoint-integration` example for comprehensive group management.

## Troubleshooting

### Common Issues

1. **Invalid TTL Value**
   ```
   Error: ttl must be one of [3h 6h 1d 3d 7d 30d 60d 90d 180d 360d]
   ```
   **Solution**: Use only the allowed TTL values listed above.

2. **Resource Not Found**
   ```
   Error: resource not found
   ```
   **Solution**: Ensure the referenced resource exists and is correctly named.

3. **Authorization Not Allowed**
   ```
   Error: authorization 'custom-role' is not valid for this resource
   ```
   **Solution**: Check available authorization levels for your resource type.

4. **JIT Approvers Required**
   ```
   Error: jit_approvers must be specified when is_jit_enabled is true
   ```
   **Solution**: Provide at least one JIT approver when enabling JIT.

## Related Examples

- `secrets-from-file/` - Reading secrets from external files
- `group-endpoint-integration/` - Managing groups and endpoints together
- Individual resource examples (postgres/, mongodb/, kubernetes/, etc.)

## Cleanup

To remove all created resources:

```bash
terraform destroy
```

This will remove all endpoints and associated resources created by this example.