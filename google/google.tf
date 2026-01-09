terraform {
  required_providers {
    adaptive = {
      source = "adaptive-scale/adaptive"
      version = "0.1.20"
    }
  }
}

provider "adaptive" {}

resource "adaptive_resource" "AdativeGoogle" {
  type          = "google"
  name          = "AdativeGoogle"
  domain        = "https://accounts.google.com"
  client_id     = "<client-id>"
  client_secret = "<client-secret>"
}
