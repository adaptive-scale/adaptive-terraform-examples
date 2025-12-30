---
layout: default
title: Cloud Platforms - Google Cloud
---

[← Back to Home](index.md)

# Google Cloud Platform (GCP) Integrations

Comprehensive guide for integrating Google Cloud services with the Adaptive Terraform Provider.

## Available GCP Integrations

- [GCP Basic Integration](#gcp-basic-integration)
- [Google OAuth Integration](#google-oauth-integration)

---

## GCP Basic Integration

Basic GCP resource configuration for general Google Cloud services.

### Configuration

```hcl
resource "adaptive_resource" "gcp" {
  type = "gcp"

  name        = "gcp-production"
  project_id  = var.gcp_project_id
  credentials = file("service-account-key.json")
  region      = "us-central1"
}
```

### Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `name` | string | Yes | Unique name for this GCP resource |
| `project_id` | string | Yes | GCP project ID |
| `credentials` | string | Yes | Service account credentials (JSON) |
| `region` | string | Yes | GCP region (e.g., us-central1, europe-west1) |

### Using Environment Variables

```hcl
resource "adaptive_resource" "gcp" {
  type = "gcp"

  name        = "gcp-production"
  project_id  = var.gcp_project_id
  # Credentials can also be set via GOOGLE_APPLICATION_CREDENTIALS env var
}
```

### Example with Multiple Regions

```hcl
resource "adaptive_resource" "gcp_us" {
  type = "gcp"

  name        = "gcp-us-production"
  project_id  = var.gcp_project_id
  credentials = file("service-account-key.json")
  region      = "us-central1"
}

resource "adaptive_resource" "gcp_eu" {
  type = "gcp"

  name        = "gcp-eu-production"
  project_id  = var.gcp_project_id
  credentials = file("service-account-key.json")
  region      = "europe-west1"
}
```

---

## Google OAuth Integration

Google authentication and OAuth integration.

### Configuration

```hcl
resource "adaptive_resource" "google_oauth" {
  type = "google"

  name          = "google-auth"
  client_id     = var.google_client_id
  client_secret = var.google_client_secret
  redirect_uri  = "https://yourapp.com/oauth/callback"
}
```

### Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `name` | string | Yes | Resource name |
| `client_id` | string | Yes | Google OAuth client ID |
| `client_secret` | string | Yes | Google OAuth client secret |
| `redirect_uri` | string | Yes | OAuth redirect URI |

### OAuth Scopes Configuration

```hcl
resource "adaptive_resource" "google_oauth" {
  type = "google"

  name          = "google-workspace-auth"
  client_id     = var.google_client_id
  client_secret = var.google_client_secret
  redirect_uri  = "https://yourapp.com/oauth/callback"
  
  scopes = [
    "https://www.googleapis.com/auth/userinfo.email",
    "https://www.googleapis.com/auth/userinfo.profile",
    "https://www.googleapis.com/auth/drive.readonly"
  ]
}
```

---

## Best Practices

### Security

1. **Use Service Accounts**: Create dedicated service accounts with least privilege
2. **Key Rotation**: Regularly rotate service account keys
3. **Enable IAM**: Use Cloud IAM for fine-grained access control
4. **VPC Service Controls**: Protect sensitive data with VPC SC
5. **Secret Manager**: Store credentials in Google Secret Manager
6. **Enable Audit Logs**: Turn on Cloud Audit Logs

### Service Account Management

```bash
# Create a service account
gcloud iam service-accounts create adaptive-terraform \
    --display-name="Adaptive Terraform Service Account"

# Grant necessary roles
gcloud projects add-iam-policy-binding PROJECT_ID \
    --member="serviceAccount:adaptive-terraform@PROJECT_ID.iam.gserviceaccount.com" \
    --role="roles/compute.admin"

# Create and download key
gcloud iam service-accounts keys create ~/key.json \
    --iam-account=adaptive-terraform@PROJECT_ID.iam.gserviceaccount.com
```

### Performance

1. **Choose Optimal Region**: Select regions closest to your users
2. **Use Cloud CDN**: Enable Cloud CDN for content delivery
3. **Enable Caching**: Use Cloud Memorystore for caching
4. **Connection Pooling**: Implement connection pooling for databases
5. **Monitoring**: Use Cloud Monitoring for performance tracking

### Cost Optimization

1. **Committed Use Discounts**: Purchase committed use contracts
2. **Sustained Use Discounts**: Benefit from automatic sustained use discounts
3. **Preemptible VMs**: Use preemptible VMs for batch workloads
4. **Budget Alerts**: Set up budget alerts and notifications
5. **Resource Labels**: Tag resources for cost allocation
6. **Auto-Scaling**: Enable auto-scaling for variable workloads

### High Availability

1. **Multi-Region Deployment**: Deploy across multiple regions
2. **Load Balancing**: Use global load balancing
3. **Health Checks**: Configure health checks for instances
4. **Backup Strategy**: Implement automated backup policies
5. **Disaster Recovery**: Plan for disaster recovery scenarios

## OAuth Implementation Examples

### Python Flask Example

```python
from flask import Flask, redirect, request, session
from google.oauth2 import id_token
from google.auth.transport import requests

app = Flask(__name__)

@app.route('/login')
def login():
    return redirect(
        f'https://accounts.google.com/o/oauth2/v2/auth?'
        f'client_id={CLIENT_ID}&'
        f'redirect_uri={REDIRECT_URI}&'
        f'response_type=code&'
        f'scope=openid%20email%20profile'
    )

@app.route('/oauth/callback')
def callback():
    code = request.args.get('code')
    # Exchange code for tokens
    # Verify ID token
    # Create session
    return redirect('/dashboard')
```

### Node.js Example

```javascript
const { OAuth2Client } = require('google-auth-library');

const client = new OAuth2Client(
  process.env.GOOGLE_CLIENT_ID,
  process.env.GOOGLE_CLIENT_SECRET,
  'https://yourapp.com/oauth/callback'
);

// Generate auth URL
const authUrl = client.generateAuthUrl({
  access_type: 'offline',
  scope: ['openid', 'email', 'profile']
});

// Handle callback
async function handleCallback(code) {
  const { tokens } = await client.getToken(code);
  client.setCredentials(tokens);
  
  const ticket = await client.verifyIdToken({
    idToken: tokens.id_token,
    audience: process.env.GOOGLE_CLIENT_ID
  });
  
  const payload = ticket.getPayload();
  return payload;
}
```

## GCP Service Integration Examples

### Cloud Storage

```hcl
resource "adaptive_resource" "gcp_storage" {
  type = "gcp"

  name        = "gcp-storage"
  project_id  = var.gcp_project_id
  credentials = file("service-account-key.json")
  
  # Additional configuration for Cloud Storage
  storage_bucket = "my-terraform-state"
}
```

### BigQuery

```hcl
resource "adaptive_resource" "gcp_bigquery" {
  type = "gcp"

  name        = "gcp-analytics"
  project_id  = var.gcp_project_id
  credentials = file("service-account-key.json")
  
  # BigQuery configuration
  dataset_id = "analytics"
  location   = "US"
}
```

## Terraform Backend Configuration

### Using GCS for State Storage

```hcl
terraform {
  backend "gcs" {
    bucket      = "my-terraform-state"
    prefix      = "adaptive/state"
    credentials = "service-account-key.json"
  }
}
```

## Examples Repository

For complete working examples, see:
- [GCP Integration](https://github.com/adaptive-scale/adaptive-terraform-examples/tree/master/gcp)
- [Google OAuth](https://github.com/adaptive-scale/adaptive-terraform-examples/tree/master/google)

## Additional Resources

- [Google Cloud Terraform Provider](https://registry.terraform.io/providers/hashicorp/google/latest/docs)
- [GCP Best Practices](https://cloud.google.com/docs/enterprise/best-practices-for-enterprise-organizations)
- [Google OAuth Documentation](https://developers.google.com/identity/protocols/oauth2)
- [Adaptive Provider Documentation](https://registry.terraform.io/providers/adaptive-scale/adaptive/latest/docs)

## Common GCP Regions

| Region ID | Location | Description |
|-----------|----------|-------------|
| us-central1 | Iowa, USA | Low CO2 |
| us-east1 | South Carolina, USA | |
| us-west1 | Oregon, USA | Low CO2 |
| europe-west1 | Belgium | Low CO2 |
| europe-west2 | London, UK | |
| asia-east1 | Taiwan | |
| asia-northeast1 | Tokyo, Japan | |
| asia-south1 | Mumbai, India | |

---

[← Back to Home](index.md) | [← Azure](azure.md) | [Next: Databases →](databases.md)
