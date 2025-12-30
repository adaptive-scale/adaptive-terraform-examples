# Terraform Provider Adaptive Examples

This directory contains example Terraform configurations for all supported integration types in the Adaptive Terraform provider.

## Directory Structure

Each integration type has its own directory containing:
- `provider.tf` - Common provider configuration
- `main.tf` - Integration-specific resource configuration

## Available Integrations

- `aws/` - AWS integration
- `awsdocumentdb/` - AWS DocumentDB integration
- `awsredshift/` - AWS Redshift integration
- `awssecretsmanager/` - AWS Secrets Manager integration
- `azure/` - Azure integration
- `azurecosmosnosql/` - Azure Cosmos DB NoSQL integration
- `azuresqlserver/` - Azure SQL Server integration
- `aruba_instant_on/` - Aruba Instant On integration
- `aruba_sw/` - Aruba Switch integration
- `cisco_ngfw/` - Cisco Next-Generation Firewall integration
- `clickhouse/` - ClickHouse integration
- `cockroachdb/` - CockroachDB integration
- `coralogix/` - Coralogix integration
- `custom_siem_webhook/` - Custom SIEM Webhook integration
- `customintegration/` - Custom integration
- `datadog/` - Datadog integration
- `elasticsearch/` - Elasticsearch integration
- `endpoints/` - Various endpoint creation patterns and configurations
- `fortinet_ngfw/` - Fortinet Next-Generation Firewall integration
- `gcp/` - Google Cloud Platform integration
- `google/` - Google OAuth integration
- `group-endpoint-integration/` - Group and endpoint management integration
- `hpe_switch/` - HPE Switch integration
- `jumpcloud/` - JumpCloud integration
- `keyspaces/` - AWS Keyspaces integration
- `kubernetes/` - Kubernetes integration
- `mongodb/` - MongoDB integration
- `mongodb_atlas/` - MongoDB Atlas integration
- `mongodb_authorization/` - MongoDB with multi-line authorization roles
- `mongodb_aws_secrets_manager/` - MongoDB with AWS Secrets Manager integration
- `msteams/` - Microsoft Teams integration
- `mysql/` - MySQL integration
- `mysql_aws_secrets_manager/` - MySQL with AWS Secrets Manager integration
- `okta/` - Okta integration
- `onelogin/` - OneLogin integration
- `paloalto_ngfw/` - Palo Alto Next-Generation Firewall integration
- `postgres/` - PostgreSQL integration
- `postgres_aws_secrets_manager/` - PostgreSQL with AWS Secrets Manager integration
- `rabbitmq/` - RabbitMQ integration
- `rdp_windows/` - RDP Windows integration
- `serverlist/` - Server list integration
- `secrets-from-file/` - Reading secrets and credentials from local files
- `services/` - Services integration
- `snowflake/` - Snowflake integration
- `snowflake_aws_secrets_manager/` - Snowflake with AWS Secrets Manager integration
- `splunk/` - Splunk integration
- `sql_server/` - SQL Server integration
- `sqlserver_aws_secrets_manager/` - SQL Server with AWS Secrets Manager integration
- `ssh/` - SSH integration
- `syslog/` - Syslog integration
- `yugabytedb/` - YugabyteDB integration
- `zerotier/` - ZeroTier integration

## Usage

To test a specific integration:

1. Navigate to the integration directory:
   ```bash
   cd examples/<integration_name>
   ```

2. Initialize Terraform:
   ```bash
   terraform init
   ```

3. Validate the configuration:
   ```bash
   terraform validate
   ```

4. Plan the deployment:
   ```bash
   terraform plan
   ```

## Notes

- These examples use test/dummy values and are not intended for production use
- Some integrations may require valid credentials or endpoints to function properly
- The configurations demonstrate the required and optional parameters for each integration type