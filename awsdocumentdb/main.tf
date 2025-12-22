resource "adaptive_resource" "awsdocumentdb" {
  type = "awsdocumentdb"

  name              = "aws-documentdb-test"
  region_name       = "us-east-1"
  access_key_id     = "test-access-key"
  secret_access_key = "test-secret-key"
  host              = "test-docdb-cluster.cluster.region.docdb.amazonaws.com"
  port              = "27017"
  username          = "testuser"
  password          = "testpassword"
}