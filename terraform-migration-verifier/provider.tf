terraform {
  required_providers {
    adaptive = {
      source = "adaptive-scale/adaptive"
      version = "0.1.20"
    }
  }
}

provider "adaptive" {}

resource "adaptive_resource" "postgres_test" {
    type          = "postgres"
    name          = "pagila42345"
    host          = "example.com"
    port          = "5432"
    username      = "postgres"
    password      = "<password>"
    database_name = "pagila"
}
