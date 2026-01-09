resource "adaptive_resource" "cockroachdb_test" {
  type          = "postgres"
  name          = "testdb"
  host          = "testhost"
  port          = 5432
  username      = "testuser"
  password      = "testpass"
  database_name = "testdb"
}