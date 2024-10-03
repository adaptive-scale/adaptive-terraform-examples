terraform {
  required_providers {
    adaptive = {
      source  = "adaptive-scale/adaptive"
      version = "0.1.3"
    }
  }
}

provider "adaptive" {}

resource "adaptive_resource" "nginx" {
  type = "services"
  name = "nginx"
  urls = "65.1.126.16:8042"
}
