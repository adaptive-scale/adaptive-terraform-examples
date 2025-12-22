resource "adaptive_resource" "mongodb_atlas" {
  type = "mongodb_atlas"

  name         = "mongodb-atlas-test"
  public_key   = "test-public-key"
  private_key  = "test-private-key"
  project_id   = "test-project-id"
}