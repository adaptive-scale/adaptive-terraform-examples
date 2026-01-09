terraform {
  required_providers {
    adaptive = {
      source  = "adaptive-scale/adaptive"
      version = "0.1.20"
    }
  }
}

provider "adaptive" {}
