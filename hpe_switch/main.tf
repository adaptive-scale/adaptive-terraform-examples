resource "adaptive_resource" "hpe_switch" {
  type = "hpe_switch"

  name      = "hpe-switch-test"
  host      = "test-hpe-host"
  api_token = "test-api-token"
  port      = "443"
  username  = "testuser"
  password  = "testpassword"
}