resource "adaptive_resource" "okta" {
  type = "okta"

  name         = "okta-test"
  domain       = "test.okta.com"
  client_id    = "test-client-id"
  client_secret = "test-client-secret"
}