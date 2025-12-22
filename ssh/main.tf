resource "adaptive_resource" "ssh" {
  type = "ssh"

  name     = "ssh-test"
  host     = "test-host"
  port     = "22"
  username = "testuser"
  password = "testpassword"
}

# Endpoint for SSH access with password authentication
resource "adaptive_endpoint" "ssh_password_access" {
  name     = "ssh-password-access"
  type     = "direct"
  ttl      = "6h"
  resource = adaptive_resource.ssh.name

  users = [
    "developer@company.com",
    "devops@company.com"
  ]

  tags = [
    "ssh",
    "development",
    "password-auth"
  ]
}

# SSH resource with key-based authentication
resource "adaptive_resource" "ssh_key" {
  type = "ssh"

  name     = "ssh-key-test"
  host     = "prod-host.example.com"
  port     = "22"
  username = "admin"
  key      = <<EOF
-----BEGIN OPENSSH PRIVATE KEY-----
b3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAABlwAAAAdzc2gtcn
NhAAAAAwEAAQAAAYEAyour+example+ssh+key+content+here
-----END OPENSSH PRIVATE KEY-----
EOF
}

# Endpoint for SSH access with key authentication and tags
resource "adaptive_endpoint" "ssh_key_access" {
  name     = "ssh-key-access"
  type     = "direct"
  ttl      = "3h"
  resource = adaptive_resource.ssh_key.name

  users = [
    "admin@company.com",
    "sre@company.com"
  ]

  tags = [
    "usermode=true",
  ]

  authorization = "admin"
}