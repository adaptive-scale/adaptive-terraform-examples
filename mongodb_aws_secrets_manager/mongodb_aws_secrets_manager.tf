terraform {
  required_providers {
    adaptive = {
      source = "adaptive-scale/adaptive"
      version = "0.0.20"
    }
  }
}

provider "adaptive" {}

resource "adaptive_resource" "mongo_todos_secrets_manager" {
  type      = "mongodb_aws_secrets_manager"
  name      = "mongo-tf"
  arn       = "arn:aws:iam::123456789012:role/secretsAccessRole"
  region    = "us-east-1"
  secret_id = "db/mongodb/todoApp"
  key       = "connectionUrl"
}
