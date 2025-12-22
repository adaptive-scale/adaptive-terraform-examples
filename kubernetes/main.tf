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

# Endpoint for Kubernetes cluster access
resource "adaptive_endpoint" "kubernetes_access" {
  name     = "k8s-cluster-access"
  type     = "direct"
  ttl      = "6h"
  resource = adaptive_resource.kubernetes.name

  users = [
    "developer@company.com",
    "platform-engineer@company.com"
  ]

  # Optional: Add authorization level for the endpoint
  authorization = adaptive_authorization.kubernetes_developer.name
}

# Create an emergency authorization for break-glass scenarios
resource "adaptive_authorization" "kubernetes_developer" {
  name          = "kubernetes_developer"
  description   = "Emergency administrative access to Kubernetes clusters"
  resource_type = "kubernetes"
  permissions   = <<EOF
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: pod-read-logs
rules:
- apiGroups: [""]
  resources: ["pods"]
  verbs: ["get", "list", "watch"]
- apiGroups: [""]
  resources: ["pods/log"]
  verbs: ["get", "list", "watch"]
EOF
}
