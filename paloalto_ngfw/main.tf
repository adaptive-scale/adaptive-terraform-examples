resource "adaptive_resource" "paloalto_ngfw" {
  type = "paloalto_ngfw"

  name        = "paloalto-ngfw-test"
  host        = "test-paloalto-host"
  username    = "testuser"
  password    = "testpassword"
  login_url   = "https://test-login.com"
  webui_port  = "443"
}