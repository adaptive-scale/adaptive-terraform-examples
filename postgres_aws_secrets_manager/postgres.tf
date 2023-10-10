terraform {
  required_providers {
    adaptive = {
      source = "adaptive-scale/adaptive"
      version = "0.0.19"
    }
  }
}

provider "adaptive" {}

resource "adaptive_resource" "pg_pagila_secrets_manager" {
  type      = "postgres_aws_secrets_manager"
  name      = "pagila-tf"
  arn       = "arn:aws:iam::123456789012:role/secretsAccessRole"
  region    = "us-east-1"
  secret_id = "db/postgres/pagila"
}
