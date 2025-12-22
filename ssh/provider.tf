terraform {
  required_providers {
    adaptive = {
      source  = "adaptive-scale/local/adaptive"
      version = "0.1.6"
    }
  }
}

provider "adaptive" {}
