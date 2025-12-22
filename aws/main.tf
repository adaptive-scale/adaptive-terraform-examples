resource "adaptive_resource" "aws" {
  type = "aws"

  name              = "aws-test"
  region_name       = "us-east-1"
  access_key_id     = "test-access-key"
  secret_access_key = "test-secret-key"
}