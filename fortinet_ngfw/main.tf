resource "adaptive_resource" "fortinet_ngfw" {
  type = "fortinet_ngfw"

  name        = "fortinet-ngfw-test"
  hostname    = "test-fortinet-host"
  username    = "testuser"
  login_url   = "https://test-login.com"
  version     = "7.0"
  webui_port  = "443"
  use_proxy   = false
}