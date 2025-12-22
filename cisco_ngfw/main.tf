resource "adaptive_resource" "cisco_ngfw" {
  type = "cisco_ngfw"

  name       = "cisco-ngfw-test"
  host       = "test-cisco-host"
  username   = "testuser"
  password   = "testpassword"
  api_token  = "test-api-token"
}