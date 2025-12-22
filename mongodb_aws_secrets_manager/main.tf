resource "adaptive_resource" "mongodb_aws_secrets_manager" {
  type = "mongodb_aws_secrets_manager"

  name      = "mongodb-aws-secrets-manager-test"
  arn       = "arn:aws:iam::123456789012:role/TestRole"
  region    = "us-east-1"
  secret_id = "test/mongodb"
}