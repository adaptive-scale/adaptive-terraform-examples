resource "adaptive_resource" "mongodb" {
  type = "mongodb"
  name          = "mongodb-test"
  uri          = "mongodb+srv://cluster0.test.mongodb.net"
}

# ============================================================================
# GROUP RESOURCE EXAMPLES
# ============================================================================

# Create a developers group with MongoDB database access
resource "adaptive_group" "mongodb_developers" {
  name     = "mongodb-developers1"
  # members  = [
  #   "analyst1@adaptive.live",
  #   "analyst2@adaptive.live"
  # ]
}

# Create a data analysts group with read-only MongoDB access
resource "adaptive_group" "mongodb_analysts" {
  name     = "mongodb-analysts"
  # members  = [
  #   "analyst1@adaptive.live",
  #   "analyst2@adaptive.live"
  # ]
  endpoints = [
    adaptive_endpoint.mongodb_readonly.name
  ]
}

# ============================================================================
# ENDPOINT RESOURCE EXAMPLES
# ============================================================================

# Endpoint for MongoDB database access
resource "adaptive_endpoint" "mongodb_access" {
  name     = "mongodb-database-access"
  type     = "direct"
  ttl      = "6h"
  resource = adaptive_resource.mongodb.name

  users = [
    "debarshi@adaptive.live"
  ]

  groups = [
    adaptive_group.mongodb_developers.name,
    adaptive_group.mongodb_analysts.name
  ]

  # Optional: Add authorization level for the endpoint
#   authorization = adaptive_authorization.mongodb_developer.name
}

# Read-only endpoint for data analysts
resource "adaptive_endpoint" "mongodb_readonly" {
  name     = "mongodb-readonly-access"
  type     = "direct"
  ttl      = "6h"
  resource = adaptive_resource.mongodb.name

  # users = [
  #   "analyst1@adaptive.live",
  #   "analyst2@adaptive.live"
  # ]

  # Optional: Add read-only authorization
#   authorization = adaptive_authorization.mongodb_readonly.name
}

# ============================================================================
# AUTHORIZATION RESOURCE EXAMPLES
# ============================================================================

# Create a developer authorization for MongoDB database access
# resource "adaptive_authorization" "mongodb_developer" {
#   name          = "mongodb-developer-role"
#   description   = "Developer access to MongoDB databases with read/write permissions"
#   resource_type = "mongodb"
#   permissions   = <<EOF
#   {
#   role: "collectionARole",
#   privileges: [
#     {
#       resource: { db: "test", collection: "prod" },
#       actions: [ "find", "update", "insert" ]
#     },    {
#       resource: { db: "test", collection: "test" },
#       actions: [ "find" ]
#     }
#   ],
#   roles: []
# }
# EOF
# }

# Create a read-only authorization for MongoDB database access
# resource "adaptive_authorization" "mongodb_readonly" {
#   name          = "mongodb-readonly-role"
#   description   = "Read-only access to MongoDB databases"
#   resource_type = "mongodb"
#   permissions   = <<EOF
#   {
#   role: "readOnlyRole",
#   privileges: [
#     {
#       resource: { db: "test", collection: "" },
#       actions: [ "find" ]
#     }
#   ],
#   roles: []
# }
# EOF
# }
