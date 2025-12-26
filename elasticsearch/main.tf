resource "adaptive_resource" "elasticsearch" {
  type = "elasticsearch"

  name     = "elasticsearch-test"
  url      = "https://test-elasticsearch.com"
  username = "testuser"
  password = "testpassword"
  index    = "test-index"
}