resource "adaptive_resource" "cockroachdb" {
  type = "cockroachdb"

  name          = "cockroachdb-test"
  host          = "localhost"
  port          = "26257"
  username      = "testuser"
  password      = "testpassword"
  database_name = "testdb"
  ssl_mode      = "verify-full"
}