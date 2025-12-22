resource "adaptive_resource" "coralogix" {
  type = "coralogix"

  name             = "coralogix-test"
  private_key      = "test-private-key"
  application_name = "test-app"
  sub_system_name  = "test-subsystem"
  url              = "https://api.coralogix.com"
}