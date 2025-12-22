# Example: Reading Secrets from Files
#
# This example demonstrates how to read sensitive configuration data
# (credentials, connection strings, certificates) from local files
# instead of hardcoding them in Terraform configuration.
#
# This approach is useful for:
# - Keeping secrets out of version control
# - Environment-specific configurations
# - CI/CD pipelines with secret files
# - Local development with test credentials

# Read secrets from JSON file
locals {
  secrets = jsondecode(file("${path.module}/secrets.json"))
}

# PostgreSQL resource using secrets from file
resource "adaptive_resource" "postgres_production" {
  type = "postgres"

  name          = "postgres-from-file"
  host          = local.secrets.databases.production.host
  port          = local.secrets.databases.production.port
  username      = local.secrets.databases.production.username
  password      = local.secrets.databases.production.password
  database_name = local.secrets.databases.production.database
  ssl_mode      = local.secrets.databases.production.ssl_mode
}

# Development PostgreSQL resource
resource "adaptive_resource" "postgres_development" {
  type = "postgres"

  name          = "postgres-dev-from-file"
  host          = local.secrets.databases.development.host
  port          = local.secrets.databases.development.port
  username      = local.secrets.databases.development.username
  password      = local.secrets.databases.development.password
  database_name = local.secrets.databases.development.database
  ssl_mode      = local.secrets.databases.development.ssl_mode
}

# MongoDB resource using connection string from file
resource "adaptive_resource" "mongodb_production" {
  type = "mongodb"

  name = "mongodb-from-file"
  uri  = local.secrets.mongodb.connection_string
}

# Kubernetes resource using secrets from file
resource "adaptive_resource" "kubernetes_cluster" {
  type = "kubernetes"

  name          = "k8s-from-file"
  api_server   = local.secrets.kubernetes.api_server
  cluster_token = local.secrets.kubernetes.cluster_token
  cluster_cert  = local.secrets.kubernetes.cluster_cert
  namespace     = "default"
}

# Endpoint for production database access
resource "adaptive_endpoint" "production_db_access" {
  name     = "prod-db-from-file"
  type     = "direct"
  ttl      = "6h"
  resource = adaptive_resource.postgres_production.name

  users = [
    "developer@company.com",
    "analyst@company.com"
  ]
}

# Endpoint for development database access
resource "adaptive_endpoint" "development_db_access" {
  name     = "dev-db-from-file"
  type     = "direct"
  ttl      = "1d"
  resource = adaptive_resource.postgres_development.name

  users = [
    "developer@company.com",
    "qa@company.com"
  ]
}

# Endpoint for MongoDB access
resource "adaptive_endpoint" "mongodb_access" {
  name     = "mongodb-from-file"
  type     = "direct"
  ttl      = "3h"
  resource = adaptive_resource.mongodb_production.name

  users = [
    "data-engineer@company.com"
  ]
}

# Endpoint for Kubernetes access
resource "adaptive_endpoint" "kubernetes_access" {
  name     = "k8s-from-file"
  type     = "direct"
  ttl      = "3h"
  resource = adaptive_resource.kubernetes_cluster.name

  users = [
    "platform-engineer@company.com"
  ]
}

# Example with environment-specific secrets file
# You can use different files for different environments
resource "adaptive_resource" "environment_specific" {
  type = "postgres"

  name          = "env-specific-db"
  host          = jsondecode(file("${path.module}/secrets-${terraform.workspace}.json")).databases.production.host
  port          = jsondecode(file("${path.module}/secrets-${terraform.workspace}.json")).databases.production.port
  username      = jsondecode(file("${path.module}/secrets-${terraform.workspace}.json")).databases.production.username
  password      = jsondecode(file("${path.module}/secrets-${terraform.workspace}.json")).databases.production.password
  database_name = jsondecode(file("${path.module}/secrets-${terraform.workspace}.json")).databases.production.database
}

# Example using YAML format (requires yamlencode/decode)
# locals {
#   secrets_yaml = yamldecode(file("${path.module}/secrets.yaml"))
# }

# Example using individual secret files
# resource "adaptive_resource" "from_individual_files" {
#   type = "postgres"
#
#   name          = "from-individual-files"
#   host          = file("${path.module}/secrets/db_host.txt")
#   port          = file("${path.module}/secrets/db_port.txt")
#   username      = file("${path.module}/secrets/db_username.txt")
#   password      = file("${path.module}/secrets/db_password.txt")
#   database_name = file("${path.module}/secrets/db_name.txt")
# }