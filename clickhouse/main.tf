resource "adaptive_resource" "clickhouse" {
  type = "clickhouse"

  name          = "clickhouse-test"
  host          = "localhost"
  port          = "9000"
  username      = "testuser"
  password      = "testpassword"
  database_name = "testdb"
}