resource "adaptive_resource" "mongodb" {
  type = "mongodb"

  name          = "mongodb-test"
  host          = "localhost"
  port          = "27017"
  username      = "testuser"
  password      = "testpassword"
  database_name = "testdb"
}

# Endpoint for MongoDB database access
resource "adaptive_endpoint" "mongodb_access" {
  name     = "mongodb-database-access"
  type     = "direct"
  ttl      = "6h"
  resource = adaptive_resource.mongodb.name

  users = [
    "developer@company.com",
    "data-engineer@company.com"
  ]

  # Optional: Add authorization level for the endpoint
  authorization = adaptive_authorization.mongodb_developer.name
}

# ============================================================================
# AUTHORIZATION RESOURCE EXAMPLES
# ============================================================================

# Create a developer authorization for MongoDB database access
resource "adaptive_authorization" "mongodb_developer" {
  name          = "mongodb-developer-role"
  description   = "Developer access to MongoDB databases with read/write permissions"
  resource_type = "mongodb"
  permissions   = <<EOF
  {
  role: "collectionARole",
  privileges: [
    {
      resource: { db: "test", collection: "prod" },
      actions: [ "find", "update", "insert" ]
    },    {
      resource: { db: "test", collection: "test" },
      actions: [ "find" ]
    }
  ],
  roles: []
}
EOF
}

