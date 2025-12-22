resource "adaptive_resource" "customintegration" {
  type = "customintegration"

  name                 = "custom-integration-test"
  image                = "test-image:latest"
  service_account_name = "test-service-account"
}