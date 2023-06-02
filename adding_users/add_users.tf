terraform {
  required_providers {
    adaptive = {
      source = "adaptive-scale/adaptive"
      version = "0.0.11"
    }
  }
}

provider "adaptive" {}

resource "adaptive_resource" "postgres_test" {
  type          = "postgres"
  name          = "somevalue"
  host          = "somevalue"
  port          = "5432"
  username      = "postgres"
  password      = "somevalue"
  database_name = "somevalue"
}

resource "adaptive_endpoint" "session_terra" {
  name         = "endpoint-terraform"
  type         = "direct"
  ttl          = "3h"
  resource = adaptive_resource.postgres_test.name
  users = ["member1@yourorg.com", "member2@yourorg.com"]
}