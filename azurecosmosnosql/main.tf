resource "adaptive_resource" "azurecosmosnosql" {
  type = "azurecosmosnosql"

  name          = "azure-cosmos-nosql-test"
  account_name  = "test-account"
  database_name = "testdb"
  container_name = "testcontainer"
}