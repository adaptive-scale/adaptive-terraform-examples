# Adaptive Terraform Provider Documentation

This directory contains the complete documentation site for the Adaptive Terraform Provider Examples, designed to be hosted on GitHub Pages.

## 📁 Documentation Structure

```
docs/
├── index.md                    # Main documentation homepage
├── getting-started.md          # Quick start guide
├── _config.yml                 # Jekyll configuration
├── SETUP.md                    # GitHub Pages setup guide
├── CNAME                       # Custom domain configuration
│
├── Cloud Platforms
│   ├── aws.md                  # AWS integrations guide
│   ├── azure.md                # Azure integrations guide
│   └── gcp.md                  # Google Cloud integrations guide
│
├── Databases
│   ├── databases.md            # Database overview
│   ├── mongodb.md              # MongoDB detailed guide
│   ├── postgres.md             # PostgreSQL detailed guide
│   └── mysql.md                # MySQL detailed guide
│
├── Security & Networking
│   └── security-networking.md  # Firewalls, IAM, networking
│
├── Monitoring & Observability
│   └── monitoring.md           # Datadog, Splunk, etc.
│
└── assets/
    └── logo.md                 # Logo assets information
```

## 🌐 Live Site

Once published, the documentation will be available at:
```
https://adaptive-scale.github.io/adaptive-terraform-examples/
```

## 🎨 Features

- ✅ **Adaptive.live Logo** - Displayed prominently on the homepage
- ✅ **50+ Integration Examples** - Organized by category
- ✅ **Detailed Guides** - Step-by-step instructions for each integration
- ✅ **Code Examples** - Working Terraform configurations
- ✅ **Best Practices** - Security, performance, and compliance guidance
- ✅ **Search-Friendly** - Optimized for discoverability
- ✅ **Mobile Responsive** - Cayman theme works on all devices
- ✅ **Syntax Highlighting** - Code blocks with proper formatting

## 📚 Pages Overview

### Main Pages

| Page | Description | URL |
|------|-------------|-----|
| **Home** | Main landing page with all integrations | `index.md` |
| **Getting Started** | Quick start guide for new users | `getting-started.md` |

### Integration Guides

| Category | Page | Covers |
|----------|------|--------|
| **Cloud** | `aws.md` | AWS, DocumentDB, Redshift, Secrets Manager, Keyspaces |
| **Cloud** | `azure.md` | Azure, Cosmos DB, Azure SQL |
| **Cloud** | `gcp.md` | GCP, Google OAuth |
| **Databases** | `databases.md` | Overview of all database integrations |
| **Databases** | `mongodb.md` | MongoDB, Atlas, authorization, groups |
| **Databases** | `postgres.md` | PostgreSQL, SSL/TLS, AWS Secrets |
| **Databases** | `mysql.md` | MySQL, AWS Secrets integration |
| **Security** | `security-networking.md` | NGFWs, switches, IAM, Kubernetes |
| **Monitoring** | `monitoring.md` | Datadog, Coralogix, Splunk, Syslog |

## 🚀 Publishing to GitHub Pages

### Quick Setup

1. **Enable GitHub Pages:**
   - Go to repository **Settings** → **Pages**
   - Source: Branch `master`, Folder `/docs`
   - Click **Save**

2. **Wait for deployment** (1-3 minutes)

3. **Access your site:**
   ```
   https://adaptive-scale.github.io/adaptive-terraform-examples/
   ```

For detailed instructions, see [SETUP.md](SETUP.md).

## 🔧 Local Development

### Prerequisites

```bash
gem install bundler jekyll
```

### Running Locally

1. **Create Gemfile** in `docs/`:
```ruby
source 'https://rubygems.org'
gem 'github-pages', group: :jekyll_plugins
```

2. **Install dependencies:**
```bash
cd docs
bundle install
```

3. **Serve locally:**
```bash
bundle exec jekyll serve
```

4. **Open browser:**
```
http://localhost:4000
```

## 📝 Adding New Pages

### Create a New Page

1. **Create markdown file** in `docs/`:
```markdown
---
layout: default
title: Your Page Title
---

# Your Page Title

Your content here...
```

2. **Link from index.md:**
```markdown
- [Your Page](your-page.md)
```

3. **Commit and push:**
```bash
git add docs/your-page.md
git commit -m "Add new documentation page"
git push
```

### Page Template

```markdown
---
layout: default
title: Integration Name
---

[← Back to Home](index.md)

# Integration Name

Brief description of the integration.

## Configuration

```hcl
resource "adaptive_resource" "example" {
  type = "integration-type"
  name = "resource-name"
  # parameters
}
```

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `name` | string | Yes | Resource name |

## Examples

[View Examples →](https://github.com/adaptive-scale/adaptive-terraform-examples/tree/master/example)

---

[← Back to Home](index.md)
```

## 🎨 Customization

### Change Theme

Edit `_config.yml`:
```yaml
theme: jekyll-theme-cayman  # or another GitHub Pages theme
```

Available themes:
- `jekyll-theme-cayman` (current)
- `jekyll-theme-minimal`
- `jekyll-theme-slate`
- `jekyll-theme-architect`
- [More themes](https://pages.github.com/themes/)

### Update Logo

Replace the logo URL in `index.md`:
```markdown
<img src="https://your-logo-url.com/logo.svg" alt="Logo" />
```

### Add Custom Domain

1. Edit `CNAME`:
```
docs.yourcompany.com
```

2. Configure DNS:
- Add CNAME record pointing to `adaptive-scale.github.io`

3. Update in GitHub Settings → Pages

## 🔍 SEO Optimization

The documentation is optimized for search engines:

- ✅ Descriptive page titles
- ✅ Clear headings (H1, H2, H3)
- ✅ Keyword-rich content
- ✅ Internal linking
- ✅ Code examples with syntax highlighting
- ✅ Mobile-responsive design

## 📊 Analytics (Optional)

Add Google Analytics in `_config.yml`:
```yaml
google_analytics: UA-XXXXXXXXX-X
```

## 🤝 Contributing

To contribute to the documentation:

1. Fork the repository
2. Create a feature branch
3. Make your changes in `docs/`
4. Test locally with Jekyll
5. Submit a pull request

## 📄 License

The documentation follows the same license as the main repository.

## 🆘 Support

- **Issues**: [GitHub Issues](https://github.com/adaptive-scale/adaptive-terraform-examples/issues)
- **Discussions**: [GitHub Discussions](https://github.com/adaptive-scale/adaptive-terraform-examples/discussions)
- **Website**: [adaptive.live](https://adaptive.live)

## 🔗 Quick Links

- [Main Repository](https://github.com/adaptive-scale/adaptive-terraform-examples)
- [Adaptive Provider](https://registry.terraform.io/providers/adaptive-scale/adaptive/latest/docs)
- [Terraform Documentation](https://www.terraform.io/docs)
- [Jekyll Documentation](https://jekyllrb.com/docs/)

---

**Last Updated**: December 30, 2025
