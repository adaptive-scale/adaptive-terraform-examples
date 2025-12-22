resource "adaptive_resource" "onelogin" {
  type = "onelogin"

  name              = "onelogin-test"
  client_id         = "test-client-id"
  client_secret     = "test-client-secret"
  api_client_id     = "test-api-client-id"
  api_client_secret = "test-api-client-secret"
  domain            = "test.onelogin.com"
}