resource "adaptive_resource" "google" {
  type = "google"

  name         = "google-test"
  client_id    = "test-client-id"
  client_secret = "test-client-secret"
  refresh_token = "test-refresh-token"
}