terraform {
  required_providers {
    adaptive = {
      source = "adaptive-scale/adaptive"
      #   version = "latest"
    }
  }
}

provider "adaptive" {}


resource "adaptive_group" "groupwithnoendpoints" {
  name      = "group-from-terraform"
  endpoints = ["staging-db", "neeraj-pagila-test"]
  members   = ["ratin.kumar.2k@gmail.com", "ratin@adaptive.live"]
}
