resource "adaptive_resource" "mysql" {
  type = "mysql"

  name          = "mysql-test"
  host          = "localhost"
  port          = "3306"
  username      = "testuser"
  password      = "testpassword"
  database_name = "testdb"
}