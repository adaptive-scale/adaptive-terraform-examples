terraform {
  required_providers {
    adaptive = {
      source = "adaptive-scale/adaptive"
      version = "0.0.6"
    }
  }
}

provider "adaptive" {}

resource "adaptive_resource" "awsk9s" {
  name          = "k8s"
  type          = "kubernetes"
  api_server    = "https://A599F7500FB8D0CB9171B57737723117.gr7.us-east-2.eks.amazonaws.com"
  cluster_token = <<EOT
<CLUSTER-TOKEN>
EOT
  cluster_cert  = <<EOT
-----BEGIN CERTIFICATE-----
<CLUSTER-CERT>
-----END CERTIFICATE-----
EOT
}
