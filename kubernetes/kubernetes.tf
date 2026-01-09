terraform {
  required_providers {
    adaptive = {
      source  = "adaptive-scale/local/adaptive"
      version = "0.1.20"
    }
  }
}

provider "adaptive" {}

resource "adaptive_resource" "awsk9s" {
  name          = "k8s"
  type          = "kubernetes"
  api_server    = "<api-server>"
  cluster_token = <<EOT
<CLUSTER-TOKEN>
EOT
  cluster_cert  = <<EOT
-----BEGIN CERTIFICATE-----
<CLUSTER-CERT>
-----END CERTIFICATE-----
EOT
}
