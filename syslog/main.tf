resource "adaptive_resource" "syslog" {
  type = "syslog"

  name     = "syslog-test"
  hostname = "test-host"
  port     = "514"
  protocol = "tcp"
}