resource "adaptive_resource" "mysql_aws_secrets_manager" {
  type = "mysql_aws_secrets_manager"

  name      = "mysql-aws-secrets-manager-test"
  arn       = "arn:aws:iam::123456789012:role/TestRole"
  region    = "us-east-1"
  secret_id = "test/mysql"
}