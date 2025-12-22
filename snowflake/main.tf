resource "adaptive_resource" "snowflake" {
  type = "snowflake"

  name              = "snowflake-test"
  database_account  = "test-account"
  database_username = "testuser"
  database_password = "testpassword"
  database_name     = "testdb"
  warehouse         = "test-warehouse"
  schema            = "test-schema"
  role              = "test-role"
  clientcert        = "test-cert"
}