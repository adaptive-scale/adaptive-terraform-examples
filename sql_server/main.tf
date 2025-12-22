resource "adaptive_resource" "sql_server" {
  type = "sql_server"

  name          = "sql-server-test"
  host          = "test-sql-server"
  port          = "1433"
  username      = "testuser"
  password      = "testpassword"
  database_name = "testdb"
}