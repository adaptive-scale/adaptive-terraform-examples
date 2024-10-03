terraform {
  required_providers {
    adaptive = {
      source = "adaptive-scale/adaptive"
      version = "0.1.3"
    }
  }
}

provider "adaptive" {}

resource "adaptive_resource" "mongodb" {
   type            = "mongodb"
   name            = "analytics"
   uri  = "mongodb+srv://<username>:<password>@<hostname>/sample_analytics?retryWrites=true&w=majority"
}
