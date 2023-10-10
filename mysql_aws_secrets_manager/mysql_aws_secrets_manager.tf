terraform {
  required_providers {
    adaptive = {
      source = "adaptive-scale/adaptive"
      version = "0.0.19"
    }
  }
}

provider "adaptive" {}

resource "adaptive_resource" "mysql_secrets_manager_test" {
  type      = "mysql_aws_secrets_manager"
  name      = "sakila-tf"
  arn       = "arn:aws:iam::123456789012:role/secretsAccessRole"
  region    = "us-east-1"
  secret_id = "db/mysql/sakila"
}
