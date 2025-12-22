resource "adaptive_resource" "aruba_instant_on" {
  type = "aruba_instant_on"

  name      = "aruba-instant-on-test"
  host      = "test-aruba-host"
  api_token = "test-api-token"
  port      = "443"
  username  = "testuser"
  password  = "testpassword"
}