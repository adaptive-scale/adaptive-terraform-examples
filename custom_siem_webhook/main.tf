resource "adaptive_resource" "custom_siem_webhook" {
  type = "custom_siem_webhook"

  name           = "custom-siem-webhook-test"
  url            = "https://test-webhook.com"
  shared_secret  = "test-shared-secret"
}