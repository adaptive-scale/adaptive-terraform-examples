terraform {
  required_providers {
    adaptive = {
      source = "adaptive-scale/adaptive"
      version = "0.1.3"
    }
  }
}

provider "adaptive" {}

resource "adaptive_resource" "document_test" {
  type          = "awsdocumentdb"
  name          = "doc1-test-02"
  uri          = "testsomething"
}