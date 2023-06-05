terraform {
  required_providers {
    adaptive = {
      source = "adaptive-scale/adaptive"
      version = "0.0.11"
    }
  }
}

provider "adaptive" {}

resource "adaptive_resource" "cockroachdb_test" {
  type          = "cockroachdb"
  name          = "testdb"
  host          = "testhost"
  port          =  5432
  username      = "testuser"
  password      = "testpass"
  database_name =   "testdb"
  root_cert  = <<EOT
-----BEGIN CERTIFICATE-----
multiline cert
-----END CERTIFICATE-----
EOT
}
