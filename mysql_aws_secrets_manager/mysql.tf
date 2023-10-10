terraform {
  required_providers {
    adaptive = {
      source = "adaptive-scale/adaptive"
      version = "0.0.6"
    }
  }
}

provider "adaptive" {}

resource "adaptive_resource" "mysql_test" {
    type          = "mysql_aws_secrets_manager"
    name          = "sakila_aws_secrets_manager"
    host          = "example.com"
    port          = "5432"
    username      = "root"
    password      = "<password>"
    database_name = "sakila"
}
