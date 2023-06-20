terraform {
  required_providers {
    adaptive = {
      source = "adaptive-scale/adaptive"
      # version = "0.0.11"
    }
  }
}

provider "adaptive" {}

resource "adaptive_resource" "ssh" {
  type     = "ssh"
  name     = "build-server-on-aws"
  username = "admin"
  port     = "22"
  host     = "65.1.126.16"
  key      = <<EOT
-----BEGIN RSA PRIVATE KEY-----
<PRIVATE-KEY>
-----END RSA PRIVATE KEY-----
EOT
}
