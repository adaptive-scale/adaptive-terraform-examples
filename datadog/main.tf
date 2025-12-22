resource "adaptive_resource" "datadog" {
  type = "datadog"

  name       = "datadog-test"
  dd_site    = "datadoghq.com"
  dd_api_key = "test-api-key"
}