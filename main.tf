terraform {
  required_providers {
    adaptive = {
      source = "adaptive-scale/local/adaptive"
    }
  }
}

provider "adaptive" {}

resource "adaptive_group" "test123" {
  name    = "terra12aasdsasdd3asd_4"
  members = ["debarshi@adaptive.live", "debarshri@gmail.com", "debarshri@gmail.com"]
}

resource "adaptive_resource" "sql_server" {
  type          = "sql_server"
  name          = "us-west2-sql-server"
  database_name = ""
  host          = "ec2-3-142-239-185.us-east-2.compute.amazonaws.com"
  port          = "1433"
  username      = "admin"
  password      = "Test@123!"
}

resource "adaptive_resource" "azuresqlserver" {
  type          = "azuresqlserver"
  name          = "azure-sql-test"
  database_name = "testdb"
  hostname      = "test.database.windows.net"
  port          = "1433"
  username      = "admin"
  password      = "Test@123!"
}

resource "adaptive_resource" "splunk" {
  type     = "splunk"
  name     = "splunk-dev"
  token_id = "f22c488f-3217-4a00-be56-a2b6734505c"
  url      = "https://prd-p-3824u.splunkcloud.com:8088/services/collector/raw"
}

resource "adaptive_resource" "datadog" {
  type       = "datadog"
  name       = "datadog-test"
  dd_site    = "datadoghq.com"
  dd_api_key = "test-api-key"
}

resource "adaptive_resource" "sqlserver_aws_secrets_manager" {
  type      = "sqlserver_aws_secrets_manager"
  name      = "awssm-sql-server-1"
  arn       = "arn:aws:iam::303746781040:role/TempAWSSecretsARN"
  region    = "us-east-2"
  secret_id = "staging/sqlserver"
}

resource "adaptive_resource" "coralogix" {
  type             = "coralogix"
  name             = "coralogix-test"
  url              = "https://api.coralogix.com"
  private_key      = "test-private-key"
  application_name = "test-app"
  sub_system_name   = "test-subsystem"
}

resource "adaptive_resource" "jumpcloud" {
  type          = "jumpcloud"
  name          = "jumpcloud-test"
  client_id     = "test-client-id"
  client_secret = "test-client-secret"
  domain        = "test-domain"
  api_key       = "test-api-key"
}

resource "adaptive_resource" "msteams" {
  type      = "msteams"
  name      = "msteams-test"
  app_id    = "test-app-id"
  app_key   = "test-app-key"
  tenant_id = "test-tenant-id"
}

resource "adaptive_resource" "yugabytedb" {
  type = "yugabytedb"

  name      = "sample-yuga"
  hostname  = "us-east-1.aa04a291-9ebe-4866-b71e-3ba66a916d60.aws.yugabyte.cloud"
  username  = "admin"
  password  = "S0uSXmWkIt8DW8GiB@4Td4C2zZ9oDjb#25$"
  ssl_mode  = "verify-full"
  root_cert = <<EOF
-----BEGIN CERTIFICATE-----
MIIGujCCBKKgAwIBAgIUAMfrcUVOw4LUutBnhHkyK2CdcD4wDQYJKoZIhvcNAQEL
BQAwgYQxCzAJBgNVBAYTAlVTMQswCQYDVQQIEwJDQTESMBAGA1UEBxMJU3Vubnl2
YWxlMRUwEwYDVQQKEwxZdWdhYnl0ZSBJbmMxFzAVBgNVBAsTDll1Z2FieXRlIENs
b3VkMSQwIgYDVQQDExtZdWdhYnl0ZSBDbG91ZCBSb290IENBIHByb2QwHhcNMjEw
ODI1MTgxNjI3WhcNMjYwODI0MTgxNjI2WjCBizELMAkGA1UEBhMCVVMxCzAJBgNV
BAgTAkNBMRIwEAYDVQQHEwlTdW5ueXZhbGUxFTATBgNVBAoTDFl1Z2FieXRlIElu
YzEXMBUGA1UECxMOWXVnYWJ5dGUgQ2xvdWQxKzApBgNVBAMTIll1Z2FieXRlIENs
b3VkIFN1Ym9yZGluYXRlIENBIHByb2QwggGiMA0GCSqGSIb3DQEBAQUAA4IBjwAw
ggGKAoIBgQDQqVXXfB3m4eTkm5EDcjOtJxeuYdodftj31g6gEsruxNrV/hVLaIMr
T9WnRfDVoArZ/a4ZszbLw8yV+YExhUpi+NcjiI76q76X9IRQ8h5GMs9Jnb/R3Ij6
Wvh7xwCglfglIut9Q+rTaLilOtTvB4K5PqJSqnkjt4iuxW7+qoeqL0yXKfNt7ar0
AyKxY/kVycdqN/7eiDRKeePu62/J3XYI/WGd0UukA2VCeSA1ZS0zjw3I9eZnhz16
UAJQrb4j2zBn7UyYHKYZSVpwbdKR/Pf0HYb/Cd+dKDLSOMWgo0ANHQYz4RwhrhGE
hKPwDSqeth4fb85w9UYjkFObdb2/S+aBZ52/+ma7CcAoFHXoho78hVW8haBtHNLu
wf5hdWFp3UFsehBx4Cwg/dvTvSwNU0M0yi81Pti3JLQcIE3JdbTFUqh6mM++8VP3
c9zv1ps49smYdAWYupGdJuOOGxKFU63ISsJ73Yps/ltS3rdcLVvpIZh3HYK7gN74
c27YLEBi5CsCAwEAAaOCAZkwggGVMA4GA1UdDwEB/wQEAwIBBjAdBgNVHSUEFjAU
BggrBgEFBQcDAQYIKwYBBQUHAwIwDwYDVR0TAQH/BAUwAwEB/zAdBgNVHQ4EFgQU
tkigYkjDqEf4Jq416pWPPKQ4CjYwHwYDVR0jBBgwFoAUYI98SpWNF9y0WPeNKy/5
CQH+EjswgY0GCCsGAQUFBwEBBIGAMH4wfAYIKwYBBQUHMAKGcGh0dHA6Ly9wcml2
YXRlY2EtY29udGVudC02MTFlMjJmNi0wMDAwLTIwYzktYTY1MC1kNGY1NDdmN2Vl
MWMuc3RvcmFnZS5nb29nbGVhcGlzLmNvbS9hYTE0MDg4M2Q0YTdhMmMwMGEwOS9j
YS5jcnQwgYIGA1UdHwR7MHkwd6B1oHOGcWh0dHA6Ly9wcml2YXRlY2EtY29udGVu
dC02MTFlMjJmNi0wMDAwLTIwYzktYTY1MC1kNGY1NDdmN2VlMWMuc3RvcmFnZS5n
b29nbGVhcGlzLmNvbS9hYTE0MDg4M2Q0YTdhMmMwMGEwOS9jcmwuY3JsMA0GCSqG
SIb3DQEBCwUAA4ICAQBtYoAQEYWi7z/f4u+4PqY0r8oDAMOwaHTESqjeWfRmv0wm
rvqCeWShCiVFKt8+Otg/TpuJ4VudwtwnT462gFhDE8ODs0uxd3ALyyzVei0CP5tx
hFWn13DWGWNQXZxetRxo9isnvveYgDKNJa5S7bhH0LKPtfpJpyBscifBCEii+tA8
5KyCbi1GjYgL56n3mE2BkoA0MTVUSyFcX0LC9DGGxRHSONePNN3VSr3LumeXoM+G
4WkhkN4c2I91ivaAEhyyg4PnfQlcFGP5FQJxIyOPe1o0knX5QNES+kxZM3Te6lPA
y8XOV7rGx82AJUBejmL/bUYKd7MN6jSCRLartINpY59zFF5HgX65D0qbQZkF9F/N
cmqlqiliE2IsTjAsaQNuxLlArtOXXlUjmCx6UdsG7UVTu3ioJFx9FerYu/EddvSI
UrU4XOOpYF1BL8Bg+5GrdHDO3+BkWazYEm1xuGVlBcFgTkOKE3wUmmWp70uP/16M
vBcCe1RzmYNJNLWUMj8e0aOLQ69zTimSdfgT/wq80boCFy4ixDf2e1J5SmOmnKNm
AEHW3Oj10kzaQBiWWLqi54A8uNYRMW95p0JANZpyoQ2ejur0KfqQQt2+YVa5q51j
0K1KVhGjMykz02dSXpxtyy25xskr8j7tFyN0abHrVi+KyLRe+DW55UldEQ9nbQ==
-----END CERTIFICATE-----
-----BEGIN CERTIFICATE-----
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
-----END CERTIFICATE-----
EOF
  port      = "5433"
}

resource "adaptive_resource" "onelogin" {
  type = "onelogin"

  name              = "onelogin-test"
  domain            = "test-domain"
  client_id         = "test-client-id"
  client_secret     = "test-client-secret"
  api_client_id     = "test-api-client-id"
  api_client_secret = "test-api-client-secret"
}

resource "adaptive_resource" "elasticsearch" {
  type     = "elasticsearch"
  name     = "elasticsearch-test"
  url      = "https://test-elasticsearch.com"
  username = "test-user"
  password = "test-password"
  index    = "test-index"
}

resource "adaptive_resource" "paloalto_ngfw" {
  type       = "paloalto_ngfw"
  name       = "paloalto-test"
  password   = "test-password"
  username   = "test-user"
  hostname   = "test-host"
  webui_port = "443"
  login_url  = "https://test-login.com"
}

resource "adaptive_resource" "fortinet_ngfw" {
  type       = "fortinet_ngfw"
  hostname   = "test-host"
  login_url  = "https://test-login.com"
  name       = "fortinet-test"
  port       = "443"
  use_proxy  = "false"
  username   = "test-user"
  version    = "7.0"
  webui_port = "443"
}

resource "adaptive_resource" "cisco_ngfw" {
  type      = "cisco_ngfw"
  name      = "cisco-test"
  host      = "test-host"
  port      = "443"
  username  = "test-user"
  password  = "test-password"
  api_token = "test-token"
}

resource "adaptive_resource" "snowflake" {
  type              = "snowflake"
  name              = "snowflake-test"
  database_account  = "test-account"
  database_username = "test-user"
  database_password = "test-password"
  database_name     = "test-db"
  warehouse         = "test-warehouse"
  schema            = "test-schema"
  clientcert        = "test-cert"
  role              = "test-role"
}

resource "adaptive_resource" "snowflake_aws_secrets_manager" {
  type      = "snowflake_aws_secrets_manager"
  name      = "snowflake-awssm-test"
  arn       = "arn:aws:iam::123456789012:role/TestRole"
  region    = "us-east-1"
  secret_id = "test/snowflake"
}

resource "adaptive_resource" "custom_siem_webhook" {
  type = "custom_siem_webhook"

  name          = "custom-siem-test"
  url           = "https://test-webhook.com"
  shared_secret = "test-secret"
}

resource "adaptive_resource" "aruba_sw" {
  type     = "aruba_sw"
  name     = "aruba-sw-test"
  hostname = "test-host"
  username = "test-user"
  password = "test-password"
}

resource "adaptive_resource" "aruba_instant_on" {
  type = "aruba_instant_on"

  name      = "aruba-instant-test"
  host      = "test-host"
  port      = "443"
  username  = "test-user"
  password  = "test-password"
  api_token = "test-token"
}

resource "adaptive_resource" "hpe_switch" {
  type = "hpe_switch"

  name      = "hpe-switch-test"
  host      = "test-host"
  port      = "443"
  username  = "test-user"
  password  = "test-password"
  api_token = "test-token"
}

resource "adaptive_resource" "syslog" {
  type = "syslog"

  name     = "12312asdfsdf"
  hostname = "sadf"
  port     = "asdfdf"
  protocol = "tcp"
}

resource "adaptive_resource" "kubernetes" {
  type = "kubernetes"

  name = "AWSStagingCluster"
  api_server = "https://A599F7500FB8D0CB9171B57737723117.gr7.us-east-2.eks.amazonaws.com"
  cluster_token = "eyJhbGciOiJSUzI1NiIsImtpZCI6IjlZUWpHUm0wZXlCMlFyLV8tRDB3N2FLRDdfX1F0aHZRQjAzX2ljUmlraDgifQ.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJkZWZhdWx0Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZWNyZXQubmFtZSI6ImFkYXB0aXZlbGl2ZS10b2tlbi1wN2pkZyIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50Lm5hbWUiOiJhZGFwdGl2ZWxpdmUiLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC51aWQiOiI1YmU4ZTJlZC02NmJlLTRiNjEtOGQxOC0zYmJiNzRiZTY0ZmYiLCJzdWIiOiJzeXN0ZW06c2VydmljZWFjY291bnQ6ZGVmYXVsdDphZGFwdGl2ZWxpdmUifQ.ArjJxS9speSK-WRH6RzJ7A9h8yKGCPJmgcE3eLYl3H9j5f_dDXtR560fbqMY98j21-Wz4tRxHzj5ygCKFvPX_nvFoaEzHm9JFurabIDv025mUvWmNNFcfWSKQbH8JrE1YY3e_7c8rCSzA6i2FC3AsCFq3EPLdlT6rUZ79Ny5gKULYrYLyM63YisWFv8R_tu3v0Hi5Zh7hZPwERw4DVQ6TCx2mL2SNBjc9fupZANT6X-vUyzquXcJ9yhaOpFoquwzkXvTESPwwPRdri-NY2siAh4jCfp7CA0QBMzj_Ki8WdprkeiF75EZp8GBt2UbzG2a5JPs9c8plxvQPzxDmlRsRQ"
  cluster_cert = <<EOF
-----BEGIN CERTIFICATE-----
MIIC5zCCAc+gAwIBAgIBADANBgkqhkiG9w0BAQsFADAVMRMwEQYDVQQDEwprdWJl
cm5ldGVzMB4XDTIyMDIwNzAwMDc1NFoXDTMyMDIwNTAwMDc1NFowFTETMBEGA1UE
AxMKa3ViZXJuZXRlczCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAKY5
zzACzihRHiwZPqTA1pERBwz/4Rgdp/oLJnomrDMq9cjeek5YWKxVnCe819Yzbe8F
zI7yRoJhiK5hnxbsoelUC/tiHViuS46/irSqmBbAQ2dkAx3N4Ul3z6OdCL3+fWI4
/l8tZ93Z5EGwLY1BEq1C75Ph8bRGg4/q+MOPM1qBsc/4yLJh2P3tRE/gUWoh83+G
qersFn1SGUO931sEtOLRGejDBGyOC8IXPZy9Gt2xZK9SU54ie1oVPsb8oTkoW6Cb
h3GqQcnWHDCNwvvRWnF8NZjm3+opwZQRb3AVvg7cuCoXW9dVTtwp0vK4IavbWoiu
UwLuOjrLdoniRlkOCxMCAwEAAaNCMEAwDgYDVR0PAQH/BAQDAgKkMA8GA1UdEwEB
/wQFMAMBAf8wHQYDVR0OBBYEFKpuecCz4yAjNn0XzxRB3F+/J7IYMA0GCSqGSIb3
DQEBCwUAA4IBAQBGMOO06eb/r0A9+/cA+a9QrP6j4PN9Rx2qPvyHGmPO50044VqY
iZsrehlXCJyZPmfZIz7pLnBUQVn3NUe/pOjPL4tH88bKCtRNKwCR/0AnoGXK/Ai0
Q0x3GW6iIy+7W6s/qbWiyWwMcQvJsltJA47LKMbrlXGzibtENuDgN8AQjFTmn1Am
eKHqaPK0F9T19st9cWtagnyhs9K3Tj7X+0W2FaQ9zVsRulxcdklOrZN1bD28+wIF
xxjdyUjCrunL+btcF7hVBWPRdLNye9pPKNqqrt4MC6kH2u3X7ezwTD77adrnknTj
ruMJGpwRzSy4eWPA3H9+GKkCwEDwwTRvV+QO
-----END CERTIFICATE-----
EOF
  namespace = "default"
  tolerations = <<EOF
tolerations:
  - key: 'node-role.kubernetes.io/master'
    operator: 'Exists'
    effect: 'NoSchedule'
EOF
  annotations = <<EOF
annotations:
   test
EOF
  node_selector = <<EOF
nodeSelector:
  asd: asdasd
EOF
}

resource "adaptive_resource" "customintegration" {
  type = "customintegration"

  name                 = "custom-test"
  image                = "test-image"
  service_account_name = "test-sa"
}

resource "adaptive_resource" "clickhouse" {
  type = "clickhouse"

  name          = "clickhouse-test"
  database_name = "test-db"
  host          = "test-host"
  port          = "9000"
  username      = "test-user"
  password      = "test-password"
}

resource "adaptive_resource" "keyspaces" {
  type = "keyspaces"

  use_service_account  = "true"
  create_if_not_exists = "true"
  name                 = "keyspaces-test"
}

resource "adaptive_resource" "rabbitmq" {
  type = "rabbitmq"

  url      = "amqp://test-rabbitmq.com"
  name     = "rabbitmq-test"
  username = "test-user"
  password = "test-password"
}

resource "adaptive_group" "test456" {
  name    = "terra456_group"
  members = ["user1@example.com", "user2@example.com"]
}

resource "adaptive_resource" "sql_server_2" {
  type = "sql_server"

  name          = "us-west2-sql-server-2"
  database_name = "testdb2"
  host          = "ec2-3-142-239-185.us-east-2.compute.amazonaws.com"
  port          = "1433"
  username      = "admin2"
  password      = "Test@123!_2"
}

resource "adaptive_resource" "splunk_2" {
  type = "splunk"
  name     = "splunk-dev-2"
  token_id = "f22c488f-3217-4a00-be56-a2b6734505c2"
  uri      = "https://prd-p-3824u.splunkcloud.com:8088/services/collector/raw"
}

resource "adaptive_resource" "datadog_2" {
  type = "datadog"

  name       = "datadog-test-2"
  dd_site    = "datadoghq.eu"
  dd_api_key = "test-api-key-2"
}

resource "adaptive_resource" "yugabytedb_2" {
  type = "yugabytedb"
  name      = "sample-yuga-2"
  hostname  = "us-east-1.aa04a291-9ebe-4866-b71e-3ba66a916d60.aws.yugabyte.cloud"
  username  = "admin2norealuser"
  password  = "S0uSXmWkIt8DW8GiB@4Td4C2zZasdasda9oDjb#25$"
  ssl_mode  = "verify-full"
  root_cert = <<EOF
-----BEGIN CERTIFICATE-----
MIIGujCCBKKgAwIBAgIUAMfrcUVOw4LUutBnhHkyK2CdcD4wDQYJKoZIhvcNAQEL
BQAwgYQxCzAJBgNVBAYTAlVTMQswCQYDVQQIEwJDQTESMBAGA1UEBxMJU3Vubnl2
YWxlMRUwEwYDVQQKEwxZdWdhYnl0ZSBJbmMxFzAVBgNVBAsTDll1Z2FieXRlIENs
b3VkMSQwIgYDVQQDExtZdWdhYnl0ZSBDbG91ZCBSb290IENBIHByb2QwHhcNMjEw
ODI1MTgxNjI3WhcNMjYwODI0MTgxNjI2WjCBizELMAkGA1UEBhMCVVMxCzAJBgNV
BAgTAkNBMRIwEAYDVQQHEwlTdW5ueXZhbGUxFTATBgNVBAoTDFl1Z2FieXRlIElu
YzEXMBUGA1UECxMOWXVnYWJ5dGUgQ2xvdWQxKzApBgNVBAMTIll1Z2FieXRlIENs
b3VkIFN1Ym9yZGluYXRlIENBIHByb2QwggGiMA0GCSqGSIb3DQEBAQUAA4IBjwAw
ggGKAoIBgQDQqVXXfB3m4eTkm5EDcjOtJxeuYdodftj31g6gEsruxNrV/hVLaIMr
T9WnRfDVoArZ/a4ZszbLw8yV+YExhUpi+NcjiI76q76X9IRQ8h5GMs9Jnb/R3Ij6
Wvh7xwCglfglIut9Q+rTaLilOtTvB4K5PqJSqnkjt4iuxW7+qoeqL0yXKfNt7ar0
AyKxY/kVycdqN/7eiDRKeePu62/J3XYI/WGd0UukA2VCeSA1ZS0zjw3I9eZnhz16
UAJQrb4j2zBn7UyYHKYZSVpwbdKR/Pf0HYb/Cd+dKDLSOMWgo0ANHQYz4RwhrhGE
hKPwDSqeth4fb85w9UYjkFObdb2/S+aBZ52/+ma7CcAoFHXoho78hVW8haBtHNLu
wf5hdWFp3UFsehBx4Cwg/dvTvSwNU0M0yi81Pti3JLQcIE3JdbTFUqh6mM++8VP3
c9zv1ps49smYdAWYupGdJuOOGxKFU63ISsJ73Yps/ltS3rdcLVvpIZh3HYK7gN74
c27YLEBi5CsCAwEAAaOCAZkwggGVMA4GA1UdDwEB/wQEAwIBBjAdBgNVHSUEFjAU
BggrBgEFBQcDAQYIKwYBBQUHAwIwDwYDVR0TAQH/BAUwAwEB/zAdBgNVHQ4EFgQU
tkigYkjDqEf4Jq416pWPPKQ4CjYwHwYDVR0jBBgwFoAUYI98SpWNF9y0WPeNKy/5
CQH+EjswgY0GCCsGAQUFBwEBBIGAMH4wfAYIKwYBBQUHMAKGcGh0dHA6Ly9wcml2
YS5jcnQwgYIGA1UdHwR7MHkwd6B1oHOGcWh0dHA6Ly9wcml2YXRlY2EtY29udGVu
dC02MTFlMjJmNi0wMDAwLTIwYzktYTY1MC1kNGY1NDdmN2VlMWMuc3RvcmFnZS5n
b29nbGVhcGlzLmNvbS9hYTE0MDg4M2Q0YTdhMmMwMGEwOS9jcmwuY3JsMA0GCSqG
SIb3DQEBCwUAA4ICAQBtYoAQEYWi7z/f4u+4PqY0r8oDAMOwaHTESqjeWfRmv0wm
rvqCeWShCiVFKt8+Otg/TpuJ4VudwtwnT462gFhDE8ODs0uxd3ALyyzVei0CP5tx
hFWn13DWGWNQXZxetRxo9isnvveYgDKNJa5S7bhH0LKPtfpJpyBscifBCEii+tA8
5KyCbi1GjYgL56n3mE2BkoA0MTVUSyFcX0LC9DGGxRHSONePNN3VSr3LumeXoM+G
UrU4XOOpYF1BL8Bg+5GrdHDO3+BkWazYEm1xuGVlBcFgTkOKE3wUmmWp70uP/16M
vBcCe1RzmYNJNLWUMj8e0aOLQ69zTimSdfgT/wq80boCFy4ixDf2e1J5SmOmnKNm
AEHW3Oj10kzaQBiWWLqi54A8uNYRMW95p0JANZpyoQ2ejur0KfqQQt2+YVa5q51j
0K1KVhGjMykz02dSXpxtyy25xskr8j7tFyN0abHrVi+KyLRe+DW55UldEQ9nbQ==
-----END CERTIFICATE-----
-----BEGIN CERTIFICATE-----
MIIF+jCCA+KgAwIBAgITQSClZYc7h4sJ9bg7LGKSKpUKFTANBgkqhkiG9w0BAQsF
ADCBhDELMAkGA1UEBhMCVVMxCzAJBgNVBAgTAkNBMRIwEAYDVQQHEwlTdW5ueXZh
bGUxFTATBgNVBAoTDFl1Z2FieXRlIEluYzEXMBUGA1UECxMOWXVnYWJ5dGUgQ2xv
dWQxJDAiBgNVBAMTG1l1Z2FieXRlIENsb3VkIFJvb3QgQ0EgcHJvZDAeFw0yMTA4
MjAwOTI4MTNaFw0zMTA4MTgwOTI4MTJaMIGEMQswCQYDVQQGEwJVUzELMAkGA1UE
CBMCQ0ExEjAQBgNVBAcTCVN1bm55dmFsZTEVMBMGA1UEChMMWXVnYWJ5dGUgSW5j
MRcwFQYDVQQLEw5ZdWdhYnl0ZSBDbG91ZDEkMCIGA1UEAxMbWXVnYWJ5dGUgQ2xv
dWQgUm9vdCBDQSBwcm9kMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEA
aQxj54YToyMUw66fdMl5PvA+tUbYwZHZEVM9NKtzGE4/j9bZUIQpj+bbJ/el8zY+
WsquZrZ1aA75tC4FzhRYMsEkrRH0iF+T6S3g4VAsn3qRfV+t/aswAAle6gPe+aP3
py5znRnJ5a0kunKEgpL7YJJ5AiqpVjyXNlL3LCvHvB5Lo4AHhVkfYafB8rs/301Q
jSsv+QkB/hI7MB8GA1UdIwQYMBaAFGCPfEqVjRfctFj3jSsv+QkB/hI7MA0GCSqG

-----END CERTIFICATE-----
EOF
  port      = "5433"
}

resource "adaptive_resource" "syslog_2" {
  type     = "syslog"
  name     = "syslog-test-2"
  hostname = "test-host-2"
  port     = "514"
  protocol = "udp"
}