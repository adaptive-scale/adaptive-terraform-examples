resource "adaptive_resource" "gcp" {
  type = "gcp"

  name          = "gcp-test"
  project_id    = "test-project"
  private_key   = "test-private-key"
  client_email  = "test@test-project.iam.gserviceaccount.com"
}