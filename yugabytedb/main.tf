resource "adaptive_resource" "yugabytedb" {
  type = "yugabytedb"

  name      = "yugabytedb-test"
  hostname  = "test.yugabyte.cloud"
  username  = "admin"
  password  = "testpassword"
  ssl_mode  = "verify-full"
  root_cert = <<EOF
-----BEGIN CERTIFICATE-----
test-certificate-content
-----END CERTIFICATE-----
EOF
  port = "5433"
}