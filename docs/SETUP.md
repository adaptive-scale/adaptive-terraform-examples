# GitHub Pages Setup Guide

This guide will help you publish the documentation site for the Adaptive Terraform Provider Examples.

## 📋 Prerequisites

- Repository admin access to `adaptive-scale/adaptive-terraform-examples`
- GitHub account

## 🚀 Setup Steps

### Step 1: Enable GitHub Pages

1. Go to your repository on GitHub: `https://github.com/adaptive-scale/adaptive-terraform-examples`
2. Click on **Settings** (top menu)
3. In the left sidebar, click **Pages**
4. Under **Source**, select:
   - **Branch**: `master` (or your default branch)
   - **Folder**: `/docs`
5. Click **Save**

### Step 2: Wait for Deployment

- GitHub will automatically build and deploy your site
- This usually takes 1-3 minutes
- You'll see a green checkmark when it's ready

### Step 3: Access Your Documentation

Your site will be available at:
```
https://adaptive-scale.github.io/adaptive-terraform-examples/
```

## 🎨 Customization Options

### Change Theme

Edit `docs/_config.yml` and change the theme line:

```yaml
# Available themes:
theme: jekyll-theme-cayman        # Default (recommended)
# theme: jekyll-theme-minimal
# theme: jekyll-theme-slate
# theme: jekyll-theme-architect
# theme: jekyll-theme-dinky
# theme: jekyll-theme-hacker
# theme: jekyll-theme-leap-day
# theme: jekyll-theme-merlot
# theme: jekyll-theme-midnight
# theme: jekyll-theme-modernist
# theme: jekyll-theme-tactile
# theme: jekyll-theme-time-machine
```

### Add Custom Domain

If you have a custom domain:

1. Edit `docs/CNAME` and add your domain:
   ```
   docs.yourcompany.com
   ```

2. Configure DNS at your domain provider:
   - Add a CNAME record pointing to: `adaptive-scale.github.io`

3. In GitHub Settings > Pages:
   - Enter your custom domain
   - Enable "Enforce HTTPS"

### Customize Site Information

Edit `docs/_config.yml`:

```yaml
title: Your Custom Title
description: Your custom description
```

## 📁 File Structure

```
docs/
├── _config.yml          # Jekyll configuration
├── index.md             # Main documentation page
└── CNAME               # Custom domain (optional)
```

## 🔧 Local Testing

To test the site locally before publishing:

1. Install Jekyll:
   ```bash
   gem install bundler jekyll
   ```

2. Create a `Gemfile` in the `docs/` directory:
   ```ruby
   source 'https://rubygems.org'
   gem 'github-pages', group: :jekyll_plugins
   ```

3. Install dependencies:
   ```bash
   cd docs
   bundle install
   ```

4. Serve the site locally:
   ```bash
   bundle exec jekyll serve
   ```

5. Open your browser to:
   ```
   http://localhost:4000
   ```

## 🔄 Updating Documentation

1. Edit files in the `docs/` directory
2. Commit and push to GitHub:
   ```bash
   git add docs/
   git commit -m "Update documentation"
   git push
   ```

3. GitHub Pages will automatically rebuild the site

## 📝 Adding New Pages

Create new `.md` files in the `docs/` directory:

```markdown
---
layout: default
title: Page Title
---

# Your Content Here

Your markdown content...
```

Link to them from `index.md`:
```markdown
[Link text](page-name.md)
```

## 🎯 Advanced Features

### Add Table of Contents

Install the TOC plugin by adding to `_config.yml`:
```yaml
plugins:
  - jekyll-toc
```

Then in your markdown:
```markdown
* TOC
{:toc}
```

### Add Search

Consider using [DocSearch](https://docsearch.algolia.com/) or [Lunr.js](https://lunrjs.com/) for search functionality.

### Add Analytics

Add Google Analytics by editing `_config.yml`:
```yaml
google_analytics: UA-XXXXXXXXX-X
```

## ✅ Verification Checklist

- [ ] GitHub Pages is enabled in repository settings
- [ ] Site builds without errors (check Actions tab)
- [ ] Site is accessible at the GitHub Pages URL
- [ ] All links work correctly
- [ ] Images and assets load properly
- [ ] Mobile-responsive design works
- [ ] Custom domain configured (if applicable)

## 🐛 Troubleshooting

### Site Not Building

1. Check the **Actions** tab in your GitHub repository
2. Look for build errors in the workflow logs
3. Common issues:
   - YAML syntax errors in `_config.yml`
   - Invalid frontmatter in markdown files
   - Missing required files

### 404 Errors

- Ensure the `/docs` folder is selected in Settings > Pages
- Check that `index.md` exists in the `docs/` directory
- Verify file names match exactly (case-sensitive)

### Theme Not Applying

- Ensure `theme:` is correctly spelled in `_config.yml`
- Try clearing your browser cache
- Wait a few minutes for GitHub to rebuild

### Custom Domain Not Working

- Verify DNS records are correct
- Wait for DNS propagation (can take 24-48 hours)
- Check that CNAME file contains only the domain (no https://)

## 📚 Additional Resources

- [GitHub Pages Documentation](https://docs.github.com/en/pages)
- [Jekyll Documentation](https://jekyllrb.com/docs/)
- [Markdown Guide](https://www.markdownguide.org/)
- [GitHub Pages Themes](https://pages.github.com/themes/)

## 🆘 Getting Help

- [GitHub Community Forum](https://github.community/)
- [Jekyll Talk Forum](https://talk.jekyllrb.com/)
- [Stack Overflow](https://stackoverflow.com/questions/tagged/github-pages)

---

**Note**: After enabling GitHub Pages, changes may take a few minutes to appear on your live site.
