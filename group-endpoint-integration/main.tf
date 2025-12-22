# Example: Managing Groups and Endpoints in Adaptive
#
# This example demonstrates how to:
# 1. Create groups with members
# 2. Create endpoints
# 3. Associate endpoints with groups
# 4. Add individual users to endpoints

# First, create some resources that endpoints can connect to
resource "adaptive_resource" "postgres_db" {
  type          = "postgres"
  name          = "postgres-production"
  host          = "prod-db.example.com"
  port          = "5432"
  username      = "dbadmin"
  password      = "secure-password"
  database_name = "production"
  ssl_mode      = "require"
}

resource "adaptive_resource" "kubernetes_cluster" {
  type               = "kubernetes"
  name               = "k8s-production"
  api_server        = "https://k8s-prod.example.com"
  cluster_token      = "eyJhbGciOiJSUzI1NiIsImtpZCI6..."
  cluster_cert       = <<EOF
-----BEGIN CERTIFICATE-----
MIICiTCCAg+gAwIBAgIJAJ8l2Z2Z3Z3ZMAOGA1UEBhMCVVMxCzAJBgNVBAgTAkNB
...
-----END CERTIFICATE-----
EOF
  namespace          = "production"
  tolerations        = <<EOF
tolerations:
  - key: 'node-role.kubernetes.io/master'
    operator: 'Exists'
    effect: 'NoSchedule'
EOF
  annotations        = <<EOF
annotations:
  environment: production
  team: platform
EOF
  node_selector       = <<EOF
nodeSelector:
  environment: production
EOF
}

# Create groups with different access levels
resource "adaptive_group" "developers" {
  name     = "developers"
  members  = [
    "alice@company.com",
    "bob@company.com",
    "charlie@company.com"
  ]
  endpoints = [
    adaptive_endpoint.dev_postgres_endpoint.name,
    adaptive_endpoint.dev_k8s_endpoint.name
  ]
}

resource "adaptive_group" "analysts" {
  name     = "data-analysts"
  members  = [
    "diana@company.com",
    "eve@company.com"
  ]
  endpoints = [
    adaptive_endpoint.analyst_postgres_endpoint.name
  ]
}

resource "adaptive_group" "admins" {
  name     = "platform-admins"
  members  = [
    "admin@company.com"
  ]
  endpoints = [
    adaptive_endpoint.admin_postgres_endpoint.name,
    adaptive_endpoint.admin_k8s_endpoint.name
  ]
}

# Create endpoints for different access patterns

# Development endpoints - accessible by developers
resource "adaptive_endpoint" "dev_postgres_endpoint" {
  name         = "dev-postgres-access"
  type         = "direct"
  ttl          = "6h"
  resource     = adaptive_resource.postgres_db.name
  users        = [
    "alice@company.com",
    "bob@company.com",
    "charlie@company.com"
  ]
}

resource "adaptive_endpoint" "dev_k8s_endpoint" {
  name         = "dev-k8s-access"
  type         = "direct"
  ttl          = "3h"
  resource     = adaptive_resource.kubernetes_cluster.name
  authorization = "developer-role"
  users        = [
    "alice@company.com",
    "bob@company.com",
    "charlie@company.com"
  ]
}

# Analyst endpoints - read-only access
resource "adaptive_endpoint" "analyst_postgres_endpoint" {
  name         = "analyst-postgres-readonly"
  type         = "direct"
  ttl          = "3h"
  resource     = adaptive_resource.postgres_db.name
  authorization = "readonly-role"
  users        = [
    "diana@company.com",
    "eve@company.com"
  ]
}

# Admin endpoints - full access with JIT approval
resource "adaptive_endpoint" "admin_postgres_endpoint" {
  name            = "admin-postgres-full"
  type            = "direct"
  ttl             = "3h"
  resource        = adaptive_resource.postgres_db.name
  authorization   = "admin-role"
  is_jit_enabled  = true
  jit_approvers   = [
    "security@company.com"
  ]
  users           = [
    "admin@company.com"
  ]
}

resource "adaptive_endpoint" "admin_k8s_endpoint" {
  name            = "admin-k8s-full"
  type            = "direct"
  ttl             = "3h"
  resource        = adaptive_resource.kubernetes_cluster.name
  authorization   = "cluster-admin"
  is_jit_enabled  = true
  jit_approvers   = [
    "security@company.com"
  ]
  users           = [
    "admin@company.com"
  ]
}

# Emergency access endpoint - for break-glass scenarios
resource "adaptive_endpoint" "emergency_access" {
  name          = "emergency-db-access"
  type          = "direct"
  ttl           = "3h"
  resource      = adaptive_resource.postgres_db.name
  authorization = "emergency-admin"
  users         = [
    "security@company.com",
    "ceo@company.com",
    "incident-response@company.com"
  ]
  pause_timeout = "15m"
}