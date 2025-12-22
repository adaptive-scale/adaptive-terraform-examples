resource "adaptive_resource" "splunk" {
  type = "splunk"

  name     = "splunk-test"
  token_id = "test-token-id"
  url      = "https://test-splunk.com:8088/services/collector/raw"
}