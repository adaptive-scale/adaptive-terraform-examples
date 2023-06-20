terraform {
  required_providers {
    adaptive = {
      source = "adaptive-scale/adaptive"
      # version = "0.0.11"
    }
  }
}

provider "adaptive" {}

resource "adaptive_resource" "mysql_test" {
    type          = "mysql"
    name          = "sakila42"
    host          = "example.com"
    port          = "5432"
    username      = "root"
    password      = "<password>"
    database_name = "sakila"
}
