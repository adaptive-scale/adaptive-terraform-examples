---
layout: default
title: Cloud Platforms - Azure
---

[← Back to Home](index.md)

# Microsoft Azure Integrations

Comprehensive guide for integrating Azure services with the Adaptive Terraform Provider.

## Available Azure Integrations

- [Azure Basic Integration](#azure-basic-integration)
- [Azure Cosmos DB (NoSQL)](#azure-cosmos-db-nosql)
- [Azure SQL Server](#azure-sql-server)

---

## Azure Basic Integration

Basic Azure resource configuration for general Azure services.

### Configuration

```hcl
resource "adaptive_resource" "azure" {
  type = "azure"

  name            = "azure-production"
  subscription_id = var.azure_subscription_id
  tenant_id       = var.azure_tenant_id
  client_id       = var.azure_client_id
  client_secret   = var.azure_client_secret
}
```

### Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `name` | string | Yes | Unique name for this Azure resource |
| `subscription_id` | string | Yes | Azure subscription ID |
| `tenant_id` | string | Yes | Azure Active Directory tenant ID |
| `client_id` | string | Yes | Service principal client ID |
| `client_secret` | string | Yes | Service principal client secret |

### Example with Managed Identity

```hcl
resource "adaptive_resource" "azure" {
  type = "azure"

  name            = "azure-production"
  subscription_id = var.azure_subscription_id
  use_msi         = true  # Use Managed Service Identity
}
```

---

## Azure Cosmos DB (NoSQL)

Multi-model database service with NoSQL API.

### Configuration

```hcl
resource "adaptive_resource" "cosmosdb" {
  type = "azurecosmosnosql"

  name         = "cosmosdb-prod"
  account_name = "my-cosmos-account"
  endpoint     = "https://my-cosmos-account.documents.azure.com:443/"
  primary_key  = var.cosmos_primary_key
  database_id  = "production-db"
}
```

### Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `name` | string | Yes | Resource name |
| `account_name` | string | Yes | Cosmos DB account name |
| `endpoint` | string | Yes | Cosmos DB endpoint URL |
| `primary_key` | string | Yes | Cosmos DB primary key |
| `database_id` | string | Yes | Database ID to connect to |

### Advanced Configuration

```hcl
resource "adaptive_resource" "cosmosdb" {
  type = "azurecosmosnosql"

  name         = "cosmosdb-advanced"
  account_name = "my-cosmos-account"
  endpoint     = "https://my-cosmos-account.documents.azure.com:443/"
  primary_key  = var.cosmos_primary_key
  database_id  = "production-db"
  
  # Optional: Additional settings
  enable_multiple_write_locations = true
  consistency_level               = "Session"
}

resource "adaptive_endpoint" "cosmos_access" {
  name     = "cosmos-data-access"
  type     = "direct"
  ttl      = "6h"
  resource = adaptive_resource.cosmosdb.name

  users = [
    "data-engineer@company.com"
  ]
}
```

---

## Azure SQL Server

Managed SQL database service on Azure.

### Configuration

```hcl
resource "adaptive_resource" "azure_sql" {
  type = "azuresqlserver"

  name          = "azure-sql-prod"
  server_name   = "my-sql-server.database.windows.net"
  port          = "1433"
  username      = var.sql_username
  password      = var.sql_password
  database_name = "production"
}
```

### Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `name` | string | Yes | Resource name |
| `server_name` | string | Yes | Azure SQL server FQDN |
| `port` | string | Yes | Port (default: 1433) |
| `username` | string | Yes | Database username |
| `password` | string | Yes | Database password |
| `database_name` | string | Yes | Database name |

### Secure Configuration with Azure Key Vault

```hcl
data "azurerm_key_vault_secret" "sql_password" {
  name         = "sql-admin-password"
  key_vault_id = var.key_vault_id
}

resource "adaptive_resource" "azure_sql" {
  type = "azuresqlserver"

  name          = "azure-sql-secure"
  server_name   = "my-sql-server.database.windows.net"
  port          = "1433"
  username      = "sqladmin"
  password      = data.azurerm_key_vault_secret.sql_password.value
  database_name = "production"
  
  # Enable encryption
  encrypt = true
}
```

---

## Best Practices

### Security

1. **Use Managed Identities**: Prefer managed identities over service principals
2. **Enable Azure AD Authentication**: Use Azure AD for database authentication
3. **Network Security**: Use private endpoints and virtual networks
4. **Enable Encryption**: Encrypt data at rest and in transit
5. **Use Key Vault**: Store secrets in Azure Key Vault
6. **Enable Auditing**: Turn on Azure SQL auditing and threat detection

### Performance

1. **Choose Correct Tier**: Select appropriate service tier for your workload
2. **Use Auto-Scaling**: Enable auto-scaling for variable workloads
3. **Optimize Queries**: Use query performance insights
4. **Enable Caching**: Use Azure Cache for Redis for frequently accessed data
5. **Geographic Distribution**: Use geo-replication for global applications

### Cost Optimization

1. **Reserved Capacity**: Purchase reserved capacity for predictable workloads
2. **Serverless Options**: Use serverless for intermittent workloads
3. **Auto-Pause**: Enable auto-pause for development databases
4. **Monitor Usage**: Use Azure Cost Management to track spending
5. **Right-Size Resources**: Regularly review and adjust resource sizes

### High Availability

1. **Geo-Replication**: Enable active geo-replication
2. **Backup Strategy**: Configure automated backups
3. **Failover Groups**: Use auto-failover groups
4. **Zone Redundancy**: Enable zone-redundant configurations
5. **Monitoring**: Set up Azure Monitor alerts

## Connection Examples

### Python Example

```python
from pymongo import MongoClient

# Azure Cosmos DB NoSQL
client = MongoClient("mongodb://my-cosmos-account.documents.azure.com:10255/",
                    username="my-cosmos-account",
                    password="primary-key",
                    ssl=True)

db = client['production-db']
collection = db['users']
```

### .NET Example

```csharp
// Azure SQL Server
using System.Data.SqlClient;

string connectionString = 
    "Server=tcp:my-sql-server.database.windows.net,1433;" +
    "Database=production;" +
    "User ID=sqladmin;" +
    "Password=password;" +
    "Encrypt=True;";

using (SqlConnection connection = new SqlConnection(connectionString))
{
    connection.Open();
    // Execute queries
}
```

## Examples Repository

For complete working examples, see:
- [Azure Integration](https://github.com/adaptive-scale/adaptive-terraform-examples/tree/master/azure)
- [Azure Cosmos DB](https://github.com/adaptive-scale/adaptive-terraform-examples/tree/master/azurecosmosnosql)
- [Azure SQL Server](https://github.com/adaptive-scale/adaptive-terraform-examples/tree/master/azuresqlserver)

## Additional Resources

- [Azure Terraform Provider](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
- [Azure Architecture Center](https://docs.microsoft.com/en-us/azure/architecture/)
- [Azure Best Practices](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/)
- [Adaptive Provider Documentation](https://registry.terraform.io/providers/adaptive-scale/adaptive/latest/docs)

---

[← Back to Home](index.md) | [← AWS](aws.md) | [Next: GCP →](gcp.md)
