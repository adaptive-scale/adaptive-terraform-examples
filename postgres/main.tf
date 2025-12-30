resource "adaptive_resource" "postgres" {
  type = "postgres"

  name          = "postgres-test"
  host          = "localhost"
  port          = "5432"
  username      = "testuser"
  password      = "testpassword"
  database_name = "testdb"
#   tls_root_cert   = "test-cert"
#   tls_cert_file = "test-client-cert" # optional
#   tls_key_file  = "test-client-key" # optional
}