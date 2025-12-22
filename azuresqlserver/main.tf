resource "adaptive_resource" "azuresqlserver" {
  type = "azuresqlserver"

  name          = "azure-sql-server-test"
  hostname      = "test.database.windows.net"
  port          = "1433"
  username      = "testuser"
  password      = "testpassword"
  database_name = "testdb"
}