resource "adaptive_resource" "mongodb" {
  type = "mongodb"

  name          = "mongodb-test"
  host          = "localhost"
  port          = "27017"
  username      = "testuser"
  password      = "testpassword"
  database_name = "testdb"
}