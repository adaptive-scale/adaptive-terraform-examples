resource "adaptive_resource" "aruba_sw" {
  type = "aruba_sw"

  name     = "aruba-sw-test"
  hostname = "test-aruba-host"
  username = "testuser"
  password = "testpassword"
}