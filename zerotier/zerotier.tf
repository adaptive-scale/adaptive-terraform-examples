
terraform {
  required_providers {
    adaptive = {
      source  = "adaptive-scale/adaptive"
      version = "0.1.3"
    }
  }
}


provider "adaptive" {}


resource "adaptive_resource" "zero_test" {
  type       = "zerotier"
  name       = "zerotier1"
  network_id = "0xxxxb752f74223627"
  api_token  = "fd1223454xuY3H4YyuwdIePNscnUyBF3zwq"
}
