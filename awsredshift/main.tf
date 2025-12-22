resource "adaptive_resource" "awsredshift" {
  type = "awsredshift"

  name              = "aws-redshift-test"
  region_name       = "us-east-1"
  access_key_id     = "test-access-key"
  secret_access_key = "test-secret-key"
  host              = "test-redshift-cluster.region.redshift.amazonaws.com"
  port              = "5439"
  username          = "testuser"
  password          = "testpassword"
  database_name     = "testdb"
}