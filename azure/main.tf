resource "adaptive_resource" "azure" {
  type = "azure"

  name          = "azure-test"
  tenant_id     = "test-tenant-id"
  application_id = "test-application-id"
  client_secret = "test-client-secret"
}