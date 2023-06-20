terraform {
  required_providers {
    adaptive = {
      source = "adaptive-scale/adaptive"
      # version = "0.0.11"
    }
  }
}

provider "adaptive" {}

resource "adaptive_resource" "adaptive-okta" {
  name          = "adaptive-okta"
  type          = "okta"
  domain        = "https://dev-00000000.okta.com/oauth2/default"
  client_id     = "client-id"
  client_secret = "client-secret"
}
