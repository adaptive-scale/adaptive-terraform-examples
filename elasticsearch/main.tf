# Elasticsearch resource configuration
resource "adaptive_resource" "elasticsearch" {
  type = "elasticsearch"

  name     = "elasticsearch-test"
  url      = "https://test-elasticsearch.com"
  username = "testuser"
  password = "testpassword"
  index    = "test-index"
}

# Additional Elasticsearch resource for analytics
resource "adaptive_resource" "elasticsearch_analytics" {
  type = "elasticsearch"

  name     = "elasticsearch-analytics"
  url      = "https://analytics-elasticsearch.com"
  username = "analyticsuser"
  password = "analyticspassword"
  index    = "analytics-index"
}

# Endpoint with direct type and authorization for read-only access
resource "adaptive_endpoint" "elasticsearch_readonly_endpoint" {
  name     = "elasticsearch-readonly"
  type     = "direct"
  ttl      = "6h"
  resource = adaptive_resource.elasticsearch.name

  # Authorization configuration for read-only access
  authorization = adaptive_authorization.elasticsearch_readonly.name

  users = [
    "test@gmail.com",
  ]
}


resource "adaptive_authorization" "elasticsearch_readonly" {
  name          = "elasticsearch-readonly-role"
  description   = "Read-only access to Elasticsearch indices"
  resource_type = "elasticsearch"
  permissions   = <<EOF
allow:
  - operation_type: GET
    route: /search-rv2a/_mapping
deny:
  - operation_type: GET
    route: /search-rv2a/_settings
  - operation_type: PUT
    route: /search-rv2a/_mapping
EOF
}