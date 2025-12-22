terraform {
  required_providers {
    adaptive = {
      source  = "adaptive-scale/adaptive"
      version = "0.1.7"
    }
  }
}

provider "adaptive" {}
