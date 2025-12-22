# Example: Creating Various Types of Endpoints
#
# This example demonstrates different ways to create endpoints in Adaptive,
# including different access patterns, TTL settings, authorization levels,
# and approval workflows.

# First, create some sample resources that endpoints can connect to
resource "adaptive_resource" "postgres_db" {
  type          = "postgres"
  name          = "endpoint-demo-postgres"
  host          = "demo-db.example.com"
  port          = "5432"
  username      = "demo_user"
  password      = "demo_password"
  database_name = "demo"
  ssl_mode      = "require"
}

resource "adaptive_resource" "mongodb_cluster" {
  type = "mongodb"
  name = "endpoint-demo-mongodb"
  uri  = "mongodb://demo-user:demo-password@mongo-cluster.example.com:27017/admin?ssl=true"
}

resource "adaptive_resource" "kubernetes_cluster" {
  type          = "kubernetes"
  name          = "endpoint-demo-k8s"
  api_server   = "https://k8s-demo.example.com"
  cluster_token = "eyJhbGciOiJSUzI1NiIsImtpZCI6..."
  cluster_cert  = <<EOF
-----BEGIN CERTIFICATE-----
MIICiTCCAg+gAwIBAgIJAJ8l2Z2Z3Z3ZMAOGA1UEBhMCVVMxCzAJBgNVBAgTAkNB
MRYwFAYDVQQHEw1TYW4gRnJhbmNpc2NvMRowGAYDVQQKExFBZGFwdGl2ZSBTY2Fs
...
-----END CERTIFICATE-----
EOF
  namespace = "demo"
}

# ============================================================================
# BASIC ENDPOINT EXAMPLES
# ============================================================================

# 1. Basic Direct Access Endpoint
# Simple endpoint with direct access to a resource
resource "adaptive_endpoint" "basic_direct" {
  name     = "basic-postgres-access"
  type     = "direct"
  ttl      = "1d"
  resource = adaptive_resource.postgres_db.name

  users = [
    "developer@company.com",
    "analyst@company.com"
  ]
}

# 2. Short-term Access Endpoint
# For temporary access needs (code reviews, debugging, etc.)
resource "adaptive_endpoint" "short_term" {
  name     = "temp-mongo-access"
  type     = "direct"
  ttl      = "3h"
  resource = adaptive_resource.mongodb_cluster.name

  users = [
    "contractor@company.com"
  ]
}

# 3. Long-term Access Endpoint
# For extended development or production support
resource "adaptive_endpoint" "long_term" {
  name     = "extended-k8s-access"
  type     = "direct"
  ttl      = "30d"
  resource = adaptive_resource.kubernetes_cluster.name

  users = [
    "platform-engineer@company.com"
  ]
}

# ============================================================================
# AUTHORIZATION-BASED ENDPOINTS
# ============================================================================

# 4. Read-Only Access Endpoint
# Restricts access to read-only operations
resource "adaptive_endpoint" "readonly_access" {
  name          = "readonly-postgres"
  type          = "direct"
  ttl           = "1d"
  resource      = adaptive_resource.postgres_db.name
  authorization = "readonly"

  users = [
    "analyst@company.com",
    "auditor@company.com"
  ]
}

# 5. Developer Access with Specific Role
# Grants developer-level permissions
resource "adaptive_endpoint" "developer_access" {
  name          = "dev-postgres-access"
  type          = "direct"
  ttl           = "6h"
  resource      = adaptive_resource.postgres_db.name
  authorization = "developer"

  users = [
    "alice@company.com",
    "bob@company.com",
    "charlie@company.com"
  ]
}

# 6. Admin Access Endpoint
# Full administrative access
resource "adaptive_endpoint" "admin_access" {
  name          = "admin-postgres-access"
  type          = "direct"
  ttl           = "3h"
  resource      = adaptive_resource.postgres_db.name
  authorization = "admin"

  users = [
    "dba@company.com"
  ]
}

# ============================================================================
# JUST-IN-TIME (JIT) APPROVAL ENDPOINTS
# ============================================================================

# 7. JIT-Enabled Endpoint for Production Access
# Requires approval before granting access
resource "adaptive_endpoint" "jit_production" {
  name          = "jit-prod-access"
  type          = "direct"
  ttl           = "6h"
  resource      = adaptive_resource.postgres_db.name
  authorization = "production-access"

  is_jit_enabled = true
  jit_approvers  = [
    "security@company.com",
    "manager@company.com"
  ]

  users = [
    "developer@company.com"
  ]
}

# 8. Emergency Access Endpoint
# Break-glass access for critical situations
resource "adaptive_endpoint" "emergency_access" {
  name          = "emergency-access"
  type          = "direct"
  ttl           = "3h"
  resource      = adaptive_resource.postgres_db.name
  authorization = "emergency-admin"

  users = [
    "security@company.com",
    "incident-response@company.com"
  ]

  # Pause timeout for emergency scenarios
  pause_timeout = "15m"
}

# ============================================================================
# MULTI-RESOURCE ENDPOINTS
# ============================================================================

# 9. Cross-Resource Access Endpoint
# Note: This demonstrates the concept - actual implementation depends on resource types
resource "adaptive_endpoint" "multi_resource" {
  name     = "multi-resource-access"
  type     = "direct"
  ttl      = "6h"
  resource = adaptive_resource.postgres_db.name

  users = [
    "platform-engineer@company.com"
  ]

  # Additional configuration would be needed for multi-resource access
  # This is a conceptual example
}

# ============================================================================
# CONDITIONAL AND DYNAMIC ENDPOINTS
# ============================================================================

# 10. Environment-Based Endpoint
# Different configurations based on workspace/environment
resource "adaptive_endpoint" "environment_based" {
  name     = "env-based-access"
  type     = "direct"
  ttl      = terraform.workspace == "production" ? "6h" : "1d"
  resource = adaptive_resource.postgres_db.name

  users = terraform.workspace == "production" ? [
    "prod-support@company.com"
  ] : [
    "developer@company.com",
    "qa@company.com"
  ]
}

# ============================================================================
# ADVANCED ENDPOINT PATTERNS
# ============================================================================

# 11. Scheduled Access Endpoint
# For regular maintenance windows
resource "adaptive_endpoint" "scheduled_maintenance" {
  name          = "maintenance-window"
  type          = "direct"
  ttl           = "7d"
  resource      = adaptive_resource.postgres_db.name
  authorization = "maintenance"

  users = [
    "maintenance@company.com"
  ]

  # Note: Actual scheduling would be handled by external automation
  # This endpoint represents the access pattern for scheduled work
}

# 12. Audit-Required Endpoint
# For sensitive operations that require audit trails
resource "adaptive_endpoint" "audit_required" {
  name          = "audit-access"
  type          = "direct"
  ttl           = "3h"
  resource      = adaptive_resource.postgres_db.name
  authorization = "audit-access"

  users = [
    "auditor@company.com"
  ]

  # Additional audit logging would be configured at the resource level
}

# ============================================================================
# OUTPUTS
# ============================================================================

output "endpoint_urls" {
  description = "Access URLs for created endpoints"
  value = {
    basic_direct      = "Access via: ${adaptive_endpoint.basic_direct.name}"
    short_term        = "Access via: ${adaptive_endpoint.short_term.name}"
    long_term         = "Access via: ${adaptive_endpoint.long_term.name}"
    readonly_access   = "Access via: ${adaptive_endpoint.readonly_access.name}"
    developer_access  = "Access via: ${adaptive_endpoint.developer_access.name}"
    admin_access      = "Access via: ${adaptive_endpoint.admin_access.name}"
    jit_production    = "JIT Access via: ${adaptive_endpoint.jit_production.name}"
    emergency_access  = "Emergency Access via: ${adaptive_endpoint.emergency_access.name}"
    environment_based = "Environment Access via: ${adaptive_endpoint.environment_based.name}"
    scheduled_access  = "Scheduled Access via: ${adaptive_endpoint.scheduled_maintenance.name}"
    audit_access      = "Audit Access via: ${adaptive_endpoint.audit_required.name}"
  }
}

output "jit_endpoints" {
  description = "Endpoints requiring JIT approval"
  value = [
    adaptive_endpoint.jit_production.name
  ]
}

output "emergency_endpoints" {
  description = "Emergency access endpoints"
  value = [
    adaptive_endpoint.emergency_access.name
  ]
}