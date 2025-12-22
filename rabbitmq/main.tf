resource "adaptive_resource" "rabbitmq" {
  type = "rabbitmq"

  name     = "rabbitmq-test"
  url      = "amqp://test-rabbitmq.com"
  username = "testuser"
  password = "testpassword"
}