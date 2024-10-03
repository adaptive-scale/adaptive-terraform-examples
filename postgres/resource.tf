terraform {
  required_providers {
    adaptive = {
      source = "adaptive-scale/adaptive"
      version = "0.1.3"
    }
  }
}

provider "adaptive" {}

resource "adaptive_resource" "cockroachdb_test" {
  type          = "postgres"
  name          = "testdb"
  host          = "testhost"
  port          =  5432
  username      = "testuser"
  password      = "testpass"
  database_name =   "testdb"
}