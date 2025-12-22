# Example: MongoDB Authorization with Multi-line Roles
#
# This example demonstrates how to configure MongoDB resources with endpoints
# that use multi-line authorization configurations containing MongoDB roles.
# The authorization field in endpoints supports MongoDB role definitions.

# MongoDB resource for production database
resource "adaptive_resource" "mongodb_production" {
  type = "mongodb"

  name          = "mongodb-production"
  host          = "prod-mongodb.example.com"
  port          = "27017"
  username      = "admin"
  password      = "secure-password"
  database_name = "production"
  uri           = "mongodb://admin:secure-password@prod-mongodb.example.com:27017/production?ssl=true&replicaSet=rs0"
}

# MongoDB resource for analytics database
resource "adaptive_resource" "mongodb_analytics" {
  type = "mongodb"

  name          = "mongodb-analytics"
  host          = "analytics-mongodb.example.com"
  port          = "27017"
  username      = "analytics"
  password      = "analytics-password"
  database_name = "analytics"
  uri           = "mongodb://analytics:analytics-password@analytics-mongodb.example.com:27017/analytics?ssl=true"
}

# MongoDB resource for development database
resource "adaptive_resource" "mongodb_development" {
  type = "mongodb"

  name          = "mongodb-development"
  host          = "dev-mongodb.example.com"
  port          = "27017"
  username      = "devuser"
  password      = "dev-password"
  database_name = "development"
  uri           = "mongodb://devuser:dev-password@dev-mongodb.example.com:27017/development"
}

# Endpoint with read-only role for analysts
resource "adaptive_endpoint" "analyst_readonly_endpoint" {
  name     = "analyst-mongodb-readonly"
  type     = "direct"
  ttl      = "6h"
  resource = adaptive_resource.mongodb_production.name

  # Multi-line authorization with MongoDB read-only role
  authorization = <<EOF
{
  "role": "read",
  "db": "production"
}
EOF

  users = [
    "analyst1@company.com",
    "analyst2@company.com",
    "data-scientist@company.com"
  ]
}

# Endpoint with read-write role for developers
resource "adaptive_endpoint" "developer_readwrite_endpoint" {
  name     = "developer-mongodb-readwrite"
  type     = "direct"
  ttl      = "3h"
  resource = adaptive_resource.mongodb_development.name

  # Multi-line authorization with MongoDB read-write role
  authorization = <<EOF
{
  "role": "readWrite",
  "db": "development"
}
EOF

  users = [
    "developer1@company.com",
    "developer2@company.com",
    "qa-engineer@company.com"
  ]
}

# Endpoint with custom role for data engineers
resource "adaptive_endpoint" "data_engineer_custom_endpoint" {
  name     = "data-engineer-mongodb-custom"
  type     = "direct"
  ttl      = "1d"
  resource = adaptive_resource.mongodb_analytics.name

  # Multi-line authorization with custom MongoDB role
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
    },
    {
      "resource": {
        "db": "analytics",
        "collection": "metrics"
      },
      "actions": ["find", "aggregate"]
    }
  ]
}
EOF

  users = [
    "data-engineer@company.com",
    "etl-developer@company.com"
  ]
}

# Endpoint with admin role for database administrators
resource "adaptive_endpoint" "dba_admin_endpoint" {
  name     = "dba-mongodb-admin"
  type     = "direct"
  ttl      = "3h"
  resource = adaptive_resource.mongodb_production.name

  # Multi-line authorization with MongoDB admin role
  authorization = <<EOF
{
  "role": "dbAdmin",
  "db": "production"
}
EOF

  users = [
    "dba@company.com",
    "database-admin@company.com"
  ]
}

# Endpoint with cluster admin role for DevOps engineers
resource "adaptive_endpoint" "devops_cluster_admin_endpoint" {
  name     = "devops-mongodb-cluster-admin"
  type     = "direct"
  ttl      = "6h"
  resource = adaptive_resource.mongodb_production.name

  # Multi-line authorization with MongoDB cluster admin role
  authorization = <<EOF
{
  "role": "clusterAdmin",
  "db": "admin"
}
EOF

  users = [
    "devops-engineer@company.com",
    "platform-admin@company.com"
  ]
}

# Endpoint with backup role for backup operations
resource "adaptive_endpoint" "backup_endpoint" {
  name     = "backup-mongodb-role"
  type     = "direct"
  ttl      = "1d"
  resource = adaptive_resource.mongodb_production.name

  # Multi-line authorization with MongoDB backup role
  authorization = <<EOF
{
  "role": "backup",
  "db": "admin"
}
EOF

  users = [
    "backup-service@company.com"
  ]
}

# Endpoint with user admin role for managing users
resource "adaptive_endpoint" "user_admin_endpoint" {
  name     = "user-admin-mongodb-role"
  type     = "direct"
  ttl      = "3h"
  resource = adaptive_resource.mongodb_production.name

  # Multi-line authorization with MongoDB user admin role
  authorization = <<EOF
{
  "role": "userAdmin",
  "db": "production"
}
EOF

  users = [
    "security-admin@company.com",
    "identity-admin@company.com"
  ]
}

# Endpoint with custom application role
resource "adaptive_endpoint" "app_readonly_endpoint" {
  name     = "app-mongodb-readonly"
  type     = "direct"
  ttl      = "7d"
  resource = adaptive_resource.mongodb_production.name

  # Multi-line authorization with custom application role
  authorization = <<EOF
{
  "role": "appReadonlyRole",
  "db": "production",
  "privileges": [
    {
      "resource": {
        "db": "production",
        "collection": "users"
      },
      "actions": ["find"]
    },
    {
      "resource": {
        "db": "production",
        "collection": "products"
      },
      "actions": ["find"]
    },
    {
      "resource": {
        "db": "production",
        "collection": "orders"
      },
      "actions": ["find", "insert"]
    }
  ]
}
EOF

  users = [
    "application-service@company.com"
  ]
}