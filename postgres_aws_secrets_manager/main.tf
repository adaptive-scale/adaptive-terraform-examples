resource "adaptive_resource" "postgres_aws_secrets_manager" {
  type = "postgres_aws_secrets_manager"

  name      = "postgres-aws-secrets-manager-test"
  arn       = "arn:aws:iam::123456789012:role/TestRole"
  region    = "us-east-1"
  secret_id = "test/postgres"
}