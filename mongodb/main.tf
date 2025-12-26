resource "adaptive_resource" "mongodb" {
  type = "mongodb"
  name          = "mongodb-test"
  uri          = "mongodb+srv://cluster0.test.mongodb.net"
}

# Endpoint for MongoDB database access
resource "adaptive_endpoint" "mongodb_access" {
  name     = "mongodb-database-access"
  type     = "direct"
  ttl      = "6h"
  resource = adaptive_resource.mongodb.name

  users = [
    "dataeng@adaptive.live"
  ]

  # Optional: Add authorization level for the endpoint
#   authorization = adaptive_authorization.mongodb_developer.name
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

