resource "adaptive_resource" "kubernetes" {
  type = "kubernetes"

  name = "kubernetes-test"
  api_server = "https://test-kubernetes-api.com"
  cluster_token = "test-cluster-token"
  cluster_cert = <<EOF
-----BEGIN CERTIFICATE-----
test-certificate-content
-----END CERTIFICATE-----
EOF
  namespace = "default"
  tolerations = <<EOF
tolerations:
  - key: 'node-role.kubernetes.io/master'
    operator: 'Exists'
    effect: 'NoSchedule'
EOF
  annotations = <<EOF
annotations:
  test: value
EOF
  node_selector = <<EOF
nodeSelector:
  environment: test
EOF
}