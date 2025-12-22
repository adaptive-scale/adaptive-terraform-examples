resource "adaptive_resource" "ssh" {
  type = "ssh"

  name     = "ssh-test"
  host     = "test-host"
  port     = "22"
  username = "testuser"
  password = "testpassword"
}