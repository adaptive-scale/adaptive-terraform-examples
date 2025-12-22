resource "adaptive_resource" "msteams" {
  type = "msteams"

  name        = "msteams-test"
  app_id      = "test-app-id"
  app_key     = "test-app-key"
  tenant_id   = "test-tenant-id"
}