resource "adaptive_resource" "postgres" {
  type = "postgres"

  name          = "postgres-test"
  host          = "localhost"
  port          = "5432"
  username      = "testuser"
  password      = "testpassword"
  database_name = "testdb"
}