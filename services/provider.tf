terraform {
  required_providers {
    adaptive = {
      source = "adaptive-scale/local/adaptive"
    }
  }
}

provider "adaptive" {}