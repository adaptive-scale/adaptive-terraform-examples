terraform {
  required_providers {
    adaptive = {
      source = "adaptive-scale/adaptive"
    }
  }
}

provider "adaptive" {
  # Configure your Adaptive credentials here
  # api_key = "your-api-key"
  # api_secret = "your-api-secret"
}