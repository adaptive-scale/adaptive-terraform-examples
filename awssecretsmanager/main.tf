resource "adaptive_resource" "awssecretsmanager" {
  type = "awssecretsmanager"

  name         = "aws-secrets-manager-test"
  region       = "us-east-1"
  access_key_id = "test-access-key"
  secret_access_key = "test-secret-key"
  secret_id    = "test/secret"
}