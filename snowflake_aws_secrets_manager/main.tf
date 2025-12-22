resource "adaptive_resource" "snowflake_aws_secrets_manager" {
  type = "snowflake_aws_secrets_manager"

  name      = "snowflake-aws-secrets-manager-test"
  arn       = "arn:aws:iam::123456789012:role/TestRole"
  region    = "us-east-1"
  secret_id = "test/snowflake"
}