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
  type            = "mongodb_atlas"
  name            = "name"
  uri             = "mongodb+srv://..."
  public_key      = "pub"
  private_key     = "priv"
  organization_id = "orgid"
  project_id      = "projectid"
}