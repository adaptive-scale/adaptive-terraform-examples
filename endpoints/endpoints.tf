terraform {
  required_providers {
    adaptive = {
      source  = "adaptive-scale/adaptive"
      version = "0.1.20"
    }
  }
}

provider "adaptive" {}

resource "adaptive_resource" "postgres_test" {
  type          = "postgres"
  name          = "postgres-test"
  host          = "example.com"
  port          = "5432"
  username      = "postgresas"
  password      = "postgrespassword"
  database_name = "postgresadmin"
}

resource "adaptive_endpoint" "session" {
  name         = "session"
  session_type = "cli"
  ttl          = "3h"
  resource = adaptive_resource.postgres_test.name
}