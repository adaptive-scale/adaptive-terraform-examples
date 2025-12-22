resource "adaptive_resource" "jumpcloud" {
  type = "jumpcloud"

  name          = "jumpcloud-test"
  api_key       = "test-api-key"
  client_id     = "test-client-id"
  client_secret = "test-client-secret"
  domain        = "test.jumpcloud.com"
}