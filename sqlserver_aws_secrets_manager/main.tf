resource "adaptive_resource" "sqlserver_aws_secrets_manager" {
  type = "sqlserver_aws_secrets_manager"

  name      = "sqlserver-aws-secrets-manager-test"
  arn       = "arn:aws:iam::123456789012:role/TestRole"
  region    = "us-east-1"
  secret_id = "test/sqlserver"
}