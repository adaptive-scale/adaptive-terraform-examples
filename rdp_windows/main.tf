resource "adaptive_resource" "rdp_windows" {
  type = "rdp_windows"

  name     = "rdp-windows-test"
  host     = "test-windows-host"
  port     = "3389"
  username = "testuser"
  password = "testpassword"
}