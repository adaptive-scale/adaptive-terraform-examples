resource "adaptive_resource" "keyspaces" {
  type = "keyspaces"

  name                 = "keyspaces-test"
  use_service_account  = true
  create_if_not_exists = true
}