---
layout: default
title: Monitoring & Observability
---

[← Back to Home](index.md)

# Monitoring & Observability Integrations

Complete guide for monitoring and observability integrations with the Adaptive Terraform Provider.

## Available Integrations

- [Datadog](#datadog)
- [Coralogix](#coralogix)
- [Splunk](#splunk)
- [Syslog](#syslog)
- [Custom SIEM Webhook](#custom-siem-webhook)

---

## Datadog

Monitoring and analytics platform for infrastructure, applications, and logs.

### Configuration

```hcl
resource "adaptive_resource" "datadog" {
  type = "datadog"
  
  name    = "datadog-monitoring"
  api_key = var.datadog_api_key
  app_key = var.datadog_app_key
  site    = "datadoghq.com"  # or datadoghq.eu for EU
}
```

### Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `name` | string | Yes | Resource name |
| `api_key` | string | Yes | Datadog API key |
| `app_key` | string | Yes | Datadog application key |
| `site` | string | No | Datadog site (default: datadoghq.com) |

### With Endpoint Access

```hcl
resource "adaptive_resource" "datadog" {
  type = "datadog"
  
  name    = "datadog-prod"
  api_key = var.datadog_api_key
  app_key = var.datadog_app_key
}

resource "adaptive_endpoint" "datadog_access" {
  name     = "datadog-dashboard-access"
  type     = "direct"
  ttl      = "8h"
  resource = adaptive_resource.datadog.name
  
  groups = [
    adaptive_group.sre_team.name
  ]
}

resource "adaptive_group" "sre_team" {
  name = "sre-engineers"
  
  members = [
    "sre1@company.com",
    "sre2@company.com"
  ]
}
```

[View Datadog Examples →](https://github.com/adaptive-scale/adaptive-terraform-examples/tree/master/datadog)

---

## Coralogix

Log analytics and monitoring platform with machine learning capabilities.

### Configuration

```hcl
resource "adaptive_resource" "coralogix" {
  type = "coralogix"
  
  name        = "coralogix-logging"
  private_key = var.coralogix_private_key
  application = "production"
  subsystem   = "api"
  endpoint    = "https://api.coralogix.com"
}
```

### Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `name` | string | Yes | Resource name |
| `private_key` | string | Yes | Coralogix private key |
| `application` | string | Yes | Application name |
| `subsystem` | string | Yes | Subsystem name |
| `endpoint` | string | No | Coralogix API endpoint |

### Log Shipping Example

```hcl
resource "adaptive_resource" "coralogix" {
  type = "coralogix"
  
  name        = "coralogix-production"
  private_key = var.coralogix_key
  application = "web-app"
  subsystem   = "backend"
  
  # Tags for organization
  tags = {
    environment = "production"
    team        = "backend"
    region      = "us-east-1"
  }
}
```

[View Coralogix Examples →](https://github.com/adaptive-scale/adaptive-terraform-examples/tree/master/coralogix)

---

## Splunk

Security information and event management (SIEM) platform.

### Configuration

```hcl
resource "adaptive_resource" "splunk" {
  type = "splunk"
  
  name     = "splunk-enterprise"
  hostname = "splunk.company.com"
  port     = "8089"
  username = var.splunk_username
  password = var.splunk_password
  index    = "main"
}
```

### Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `name` | string | Yes | Resource name |
| `hostname` | string | Yes | Splunk server hostname |
| `port` | string | Yes | Splunk management port (default: 8089) |
| `username` | string | Yes | Splunk username |
| `password` | string | Yes | Splunk password |
| `index` | string | No | Default Splunk index |

### Advanced Configuration

```hcl
resource "adaptive_resource" "splunk" {
  type = "splunk"
  
  name     = "splunk-security"
  hostname = "splunk.company.com"
  port     = "8089"
  username = var.splunk_username
  password = var.splunk_password
  
  # Multiple indexes
  indexes = ["security", "audit", "application"]
  
  # SSL configuration
  ssl_verify = true
  ca_cert    = file("splunk-ca.pem")
}

resource "adaptive_group" "security_analysts" {
  name = "security-analysts"
  
  members = [
    "analyst1@company.com",
    "analyst2@company.com"
  ]
  
  endpoints = [
    adaptive_endpoint.splunk_access.name
  ]
}

resource "adaptive_endpoint" "splunk_access" {
  name     = "splunk-analyst-access"
  type     = "direct"
  ttl      = "12h"
  resource = adaptive_resource.splunk.name
}
```

[View Splunk Examples →](https://github.com/adaptive-scale/adaptive-terraform-examples/tree/master/splunk)

---

## Syslog

Standard logging protocol for system and application logs.

### Configuration

```hcl
resource "adaptive_resource" "syslog" {
  type = "syslog"
  
  name     = "syslog-server"
  hostname = "syslog.company.com"
  port     = "514"
  protocol = "udp"  # or "tcp"
}
```

### Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `name` | string | Yes | Resource name |
| `hostname` | string | Yes | Syslog server hostname |
| `port` | string | Yes | Syslog port (default: 514) |
| `protocol` | string | No | Protocol: udp or tcp (default: udp) |

### TLS Syslog

```hcl
resource "adaptive_resource" "syslog_tls" {
  type = "syslog"
  
  name     = "syslog-secure"
  hostname = "syslog.company.com"
  port     = "6514"
  protocol = "tcp"
  
  # TLS configuration
  tls        = true
  tls_ca_cert = file("ca-cert.pem")
}
```

[View Syslog Examples →](https://github.com/adaptive-scale/adaptive-terraform-examples/tree/master/syslog)

---

## Custom SIEM Webhook

Generic webhook integration for custom SIEM solutions.

### Configuration

```hcl
resource "adaptive_resource" "custom_siem" {
  type = "custom_siem_webhook"
  
  name        = "custom-siem"
  webhook_url = "https://siem.company.com/webhook"
  auth_token  = var.siem_auth_token
}
```

### Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `name` | string | Yes | Resource name |
| `webhook_url` | string | Yes | Webhook endpoint URL |
| `auth_token` | string | No | Authentication token |
| `headers` | map | No | Custom HTTP headers |

### Advanced Webhook Configuration

```hcl
resource "adaptive_resource" "custom_siem" {
  type = "custom_siem_webhook"
  
  name        = "custom-siem-advanced"
  webhook_url = "https://siem.company.com/api/events"
  auth_token  = var.siem_token
  
  # Custom headers
  headers = {
    "X-API-Version" = "2.0"
    "X-Tenant-ID"   = "company-prod"
  }
  
  # Events to forward
  events = [
    "access_granted",
    "access_denied",
    "login_success",
    "login_failure",
    "config_change"
  ]
  
  # Webhook format
  format = "json"
  
  # Retry configuration
  retry_attempts = 3
  retry_delay    = 5
}
```

### Webhook Payload Example

```json
{
  "event_type": "access_granted",
  "timestamp": "2025-12-30T10:30:00Z",
  "user": "engineer@company.com",
  "resource": "postgres-production",
  "endpoint": "database-access",
  "ip_address": "192.168.1.100",
  "ttl": "8h",
  "metadata": {
    "authorization": "developer-role",
    "group": "backend-developers"
  }
}
```

[View Custom SIEM Examples →](https://github.com/adaptive-scale/adaptive-terraform-examples/tree/master/custom_siem_webhook)

---

## Complete Monitoring Stack

### Comprehensive Monitoring Setup

```hcl
# Datadog for infrastructure monitoring
resource "adaptive_resource" "datadog" {
  type = "datadog"
  
  name    = "datadog-infrastructure"
  api_key = var.datadog_api_key
  app_key = var.datadog_app_key
}

# Splunk for security events
resource "adaptive_resource" "splunk" {
  type = "splunk"
  
  name     = "splunk-security"
  hostname = "splunk.company.com"
  port     = "8089"
  username = var.splunk_username
  password = var.splunk_password
  index    = "security"
}

# Coralogix for application logs
resource "adaptive_resource" "coralogix" {
  type = "coralogix"
  
  name        = "coralogix-apps"
  private_key = var.coralogix_key
  application = "web-applications"
  subsystem   = "production"
}

# Custom SIEM for compliance
resource "adaptive_resource" "compliance_siem" {
  type = "custom_siem_webhook"
  
  name        = "compliance-siem"
  webhook_url = "https://compliance.company.com/events"
  auth_token  = var.compliance_token
}

# SRE Team Access
resource "adaptive_group" "sre_team" {
  name = "sre-team"
  
  members = [
    "sre1@company.com",
    "sre2@company.com"
  ]
  
  endpoints = [
    adaptive_endpoint.datadog_access.name,
    adaptive_endpoint.splunk_access.name
  ]
}

resource "adaptive_endpoint" "datadog_access" {
  name     = "datadog-sre-access"
  type     = "direct"
  ttl      = "12h"
  resource = adaptive_resource.datadog.name
}

resource "adaptive_endpoint" "splunk_access" {
  name     = "splunk-sre-access"
  type     = "direct"
  ttl      = "12h"
  resource = adaptive_resource.splunk.name
}
```

---

## Best Practices

### Log Management

1. **Structured Logging**: Use JSON format for logs
2. **Log Levels**: Implement appropriate log levels
3. **Retention Policies**: Define retention periods
4. **PII Protection**: Sanitize sensitive data
5. **Log Aggregation**: Centralize logs

### Monitoring Strategy

1. **Golden Signals**: Monitor latency, traffic, errors, saturation
2. **Alerting**: Set up meaningful alerts
3. **Dashboards**: Create role-specific dashboards
4. **SLOs**: Define service level objectives
5. **Capacity Planning**: Monitor resource usage trends

### Security Monitoring

1. **Audit Logging**: Log all access attempts
2. **Anomaly Detection**: Use ML for anomaly detection
3. **Real-time Alerts**: Alert on security events
4. **Compliance**: Maintain audit trails
5. **Incident Response**: Integrate with IR workflows

---

## Integration Examples

### Datadog Dashboard Provisioning

```hcl
resource "adaptive_resource" "datadog" {
  type = "datadog"
  
  name    = "datadog-prod"
  api_key = var.datadog_api_key
  app_key = var.datadog_app_key
}

# Automatically create dashboards
resource "datadog_dashboard" "api_performance" {
  title       = "API Performance"
  description = "API metrics and performance indicators"
  
  widget {
    timeseries_definition {
      request {
        q = "avg:api.response_time{env:production}"
      }
      title = "API Response Time"
    }
  }
}
```

### Splunk Search Automation

```hcl
resource "adaptive_resource" "splunk" {
  type = "splunk"
  
  name     = "splunk-automation"
  hostname = "splunk.company.com"
  port     = "8089"
  username = var.splunk_username
  password = var.splunk_password
}

# Saved searches
resource "splunk_saved_search" "failed_logins" {
  name   = "Failed Login Attempts"
  search = "index=security sourcetype=auth action=failure | stats count by user"
  
  schedule {
    cron_schedule = "*/15 * * * *"
  }
  
  alert {
    threshold = 5
    action    = "email"
  }
}
```

---

## Troubleshooting

### Common Issues

1. **Connection Failures**: Verify network connectivity and credentials
2. **Missing Logs**: Check log shipping configuration
3. **High Latency**: Review data volume and network bandwidth
4. **Authentication Errors**: Verify API keys and tokens

---

## Additional Resources

- [Datadog Documentation](https://docs.datadoghq.com/)
- [Coralogix Documentation](https://coralogix.com/docs/)
- [Splunk Documentation](https://docs.splunk.com/)
- [GitHub Examples](https://github.com/adaptive-scale/adaptive-terraform-examples/)

---

[← Back to Home](index.md)
