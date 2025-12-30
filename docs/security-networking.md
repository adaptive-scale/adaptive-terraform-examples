---
layout: default
title: Security & Networking
---

[← Back to Home](index.md)

# Security & Networking Integrations

Complete guide for security and networking integrations with the Adaptive Terraform Provider.

## Categories

- [Next-Generation Firewalls](#next-generation-firewalls)
- [Network Infrastructure](#network-infrastructure)
- [Identity & Access Management](#identity--access-management)

---

## Next-Generation Firewalls

### Cisco NGFW

```hcl
resource "adaptive_resource" "cisco_ngfw" {
  type = "cisco_ngfw"
  
  name         = "cisco-firewall-prod"
  hostname     = "firewall.example.com"
  username     = var.cisco_username
  password     = var.cisco_password
  api_endpoint = "https://firewall.example.com/api"
}
```

[View Cisco NGFW Examples →](https://github.com/adaptive-scale/adaptive-terraform-examples/tree/master/cisco_ngfw)

### Fortinet NGFW

```hcl
resource "adaptive_resource" "fortinet_ngfw" {
  type = "fortinet_ngfw"
  
  name         = "fortinet-firewall-prod"
  hostname     = "fortinet.example.com"
  api_key      = var.fortinet_api_key
  api_endpoint = "https://fortinet.example.com/api/v2"
}
```

[View Fortinet NGFW Examples →](https://github.com/adaptive-scale/adaptive-terraform-examples/tree/master/fortinet_ngfw)

### Palo Alto NGFW

```hcl
resource "adaptive_resource" "paloalto_ngfw" {
  type = "paloalto_ngfw"
  
  name         = "paloalto-firewall-prod"
  hostname     = "paloalto.example.com"
  username     = var.paloalto_username
  password     = var.paloalto_password
  api_endpoint = "https://paloalto.example.com/api"
}
```

[View Palo Alto NGFW Examples →](https://github.com/adaptive-scale/adaptive-terraform-examples/tree/master/paloalto_ngfw)

---

## Network Infrastructure

### Aruba Instant On

```hcl
resource "adaptive_resource" "aruba_instant_on" {
  type = "aruba_instant_on"
  
  name         = "aruba-network"
  client_id    = var.aruba_client_id
  client_secret = var.aruba_client_secret
  region       = "us"
}
```

### Aruba Switch

```hcl
resource "adaptive_resource" "aruba_switch" {
  type = "aruba_sw"
  
  name     = "aruba-switch-core"
  hostname = "switch.example.com"
  username = var.aruba_username
  password = var.aruba_password
}
```

### HPE Switch

```hcl
resource "adaptive_resource" "hpe_switch" {
  type = "hpe_switch"
  
  name     = "hpe-switch-01"
  hostname = "hpe-switch.example.com"
  username = var.hpe_username
  password = var.hpe_password
}
```

### Kubernetes

```hcl
resource "adaptive_resource" "kubernetes" {
  type = "kubernetes"
  
  name         = "k8s-production"
  api_server   = "https://k8s.example.com:6443"
  ca_cert      = file("ca.pem")
  client_cert  = file("client.pem")
  client_key   = file("client-key.pem")
}
```

### ZeroTier

```hcl
resource "adaptive_resource" "zerotier" {
  type = "zerotier"
  
  name       = "zerotier-network"
  api_token  = var.zerotier_token
  network_id = var.zerotier_network_id
}
```

---

## Identity & Access Management

### Okta

```hcl
resource "adaptive_resource" "okta" {
  type = "okta"
  
  name      = "okta-production"
  domain    = "company.okta.com"
  api_token = var.okta_api_token
}
```

**Features:**
- User management
- Group synchronization
- Application access control
- SSO integration

[View Okta Examples →](https://github.com/adaptive-scale/adaptive-terraform-examples/tree/master/okta)

### OneLogin

```hcl
resource "adaptive_resource" "onelogin" {
  type = "onelogin"
  
  name          = "onelogin-production"
  client_id     = var.onelogin_client_id
  client_secret = var.onelogin_client_secret
  region        = "us"
}
```

**Features:**
- Identity management
- Multi-factor authentication
- Single sign-on
- User provisioning

[View OneLogin Examples →](https://github.com/adaptive-scale/adaptive-terraform-examples/tree/master/onelogin)

### JumpCloud

```hcl
resource "adaptive_resource" "jumpcloud" {
  type = "jumpcloud"
  
  name      = "jumpcloud-directory"
  api_key   = var.jumpcloud_api_key
  org_id    = var.jumpcloud_org_id
}
```

**Features:**
- Directory-as-a-Service
- Device management
- LDAP/RADIUS
- System access control

[View JumpCloud Examples →](https://github.com/adaptive-scale/adaptive-terraform-examples/tree/master/jumpcloud)

---

## Complete Security Setup Example

### Multi-Layer Security Configuration

```hcl
# Firewall Configuration
resource "adaptive_resource" "firewall" {
  type = "paloalto_ngfw"
  
  name         = "perimeter-firewall"
  hostname     = "firewall.company.net"
  username     = var.fw_username
  password     = var.fw_password
  api_endpoint = "https://firewall.company.net/api"
}

# Identity Provider
resource "adaptive_resource" "idp" {
  type = "okta"
  
  name      = "corporate-idp"
  domain    = "company.okta.com"
  api_token = var.okta_token
}

# Network Access Control
resource "adaptive_resource" "vpn" {
  type = "zerotier"
  
  name       = "corporate-vpn"
  api_token  = var.zerotier_token
  network_id = var.zerotier_network
}

# Security Group
resource "adaptive_group" "security_admins" {
  name = "security-administrators"
  
  members = [
    "security-admin1@company.com",
    "security-admin2@company.com"
  ]
  
  endpoints = [
    adaptive_endpoint.firewall_access.name,
    adaptive_endpoint.network_access.name
  ]
}

# Firewall Endpoint
resource "adaptive_endpoint" "firewall_access" {
  name     = "firewall-admin-access"
  type     = "direct"
  ttl      = "4h"
  resource = adaptive_resource.firewall.name
}

# Network Endpoint
resource "adaptive_endpoint" "network_access" {
  name     = "network-admin-access"
  type     = "direct"
  ttl      = "8h"
  resource = adaptive_resource.vpn.name
}
```

---

## Best Practices

### Firewall Management

1. **Change Control**: Use version control for firewall rules
2. **Audit Logging**: Enable comprehensive logging
3. **Regular Reviews**: Audit firewall rules quarterly
4. **Least Privilege**: Implement default-deny policies
5. **Segmentation**: Use network segmentation

### Identity Management

1. **SSO Integration**: Implement single sign-on
2. **MFA Enforcement**: Require multi-factor authentication
3. **Role-Based Access**: Use RBAC for permissions
4. **Regular Audits**: Review user access quarterly
5. **Automated Provisioning**: Automate user lifecycle

### Network Security

1. **Zero Trust**: Implement zero trust architecture
2. **Encryption**: Use TLS/SSL for all communications
3. **Monitoring**: Continuous network monitoring
4. **Incident Response**: Have IR plan in place
5. **Patch Management**: Keep systems updated

---

## Security Compliance

### SOC 2 Compliance

```hcl
# Implement time-limited access
resource "adaptive_endpoint" "compliance_access" {
  name     = "soc2-compliant-access"
  type     = "direct"
  ttl      = "2h"  # Short-lived access
  resource = adaptive_resource.firewall.name
  
  # Audit logging enabled by default
}

# Require authorization
resource "adaptive_authorization" "compliance_role" {
  name          = "soc2-firewall-admin"
  resource_type = "paloalto_ngfw"
  
  permissions = jsonencode({
    actions = ["view", "modify"]
    require_approval = true
  })
}
```

### GDPR Compliance

```hcl
# Data access controls
resource "adaptive_authorization" "gdpr_readonly" {
  name          = "gdpr-readonly-access"
  resource_type = "postgres"
  
  permissions = jsonencode({
    grants = ["SELECT"]
    # Exclude PII columns
    excluded_columns = ["ssn", "passport", "credit_card"]
  })
}
```

---

## Monitoring & Alerts

### Integration with SIEM

```hcl
resource "adaptive_resource" "siem_webhook" {
  type = "custom_siem_webhook"
  
  name         = "security-siem"
  webhook_url  = "https://siem.company.com/webhook"
  auth_token   = var.siem_token
  
  # Events to forward
  events = [
    "login_success",
    "login_failure",
    "access_granted",
    "access_denied",
    "configuration_change"
  ]
}
```

### Splunk Integration

```hcl
resource "adaptive_resource" "splunk" {
  type = "splunk"
  
  name          = "splunk-security"
  hostname      = "splunk.company.com"
  port          = "8089"
  username      = var.splunk_username
  password      = var.splunk_password
  index         = "security"
}
```

---

## Access Control Examples

### Time-Based Access

```hcl
resource "adaptive_endpoint" "business_hours" {
  name     = "business-hours-access"
  type     = "direct"
  ttl      = "8h"
  resource = adaptive_resource.firewall.name
  
  users = [
    "admin@company.com"
  ]
  
  # Access only during business hours
  schedule = {
    timezone = "America/New_York"
    allowed_hours = {
      monday    = ["09:00-17:00"]
      tuesday   = ["09:00-17:00"]
      wednesday = ["09:00-17:00"]
      thursday  = ["09:00-17:00"]
      friday    = ["09:00-17:00"]
    }
  }
}
```

### Emergency Access

```hcl
resource "adaptive_endpoint" "emergency_access" {
  name     = "emergency-firewall-access"
  type     = "direct"
  ttl      = "1h"  # Very short-lived
  resource = adaptive_resource.firewall.name
  
  # Require approval
  require_approval = true
  approvers = [
    "security-director@company.com",
    "ciso@company.com"
  ]
}
```

---

## Examples Repository

- [Cisco NGFW](https://github.com/adaptive-scale/adaptive-terraform-examples/tree/master/cisco_ngfw)
- [Fortinet NGFW](https://github.com/adaptive-scale/adaptive-terraform-examples/tree/master/fortinet_ngfw)
- [Palo Alto NGFW](https://github.com/adaptive-scale/adaptive-terraform-examples/tree/master/paloalto_ngfw)
- [Okta](https://github.com/adaptive-scale/adaptive-terraform-examples/tree/master/okta)
- [Kubernetes](https://github.com/adaptive-scale/adaptive-terraform-examples/tree/master/kubernetes)

---

[← Back to Home](index.md)
