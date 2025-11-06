# 🔧 Troubleshooting Guide

Quick fixes for common issues when running the Backlog Analyzer.

## 🚨 **Setup Issues**

### **Problem: Azure CLI not found**
**Error:** `az: command not found`
**Solution:**
```bash
# Install Azure CLI
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

# Or on Windows
winget install Microsoft.AzureCLI
```

### **Problem: Not logged into Azure**  
**Error:** `Please run 'az login'`
**Solution:**
```bash
az login
az account set --subscription "Your Subscription Name"
```

### **Problem: GitHub token invalid**
**Error:** `Authentication failed` or `401 Unauthorized`
**Solutions:**
1. Check token has Copilot access: https://github.com/settings/copilot
2. Verify token scopes: `read:user`, `copilot`
3. Generate new token: https://github.com/settings/tokens
4. Test token: `curl -H "Authorization: token YOUR_TOKEN" https://api.github.com/user`

---

## 🤖 **Pipeline Issues**

### **Problem: No work items found**
**Error:** `⚠️ No work items found matching criteria`
**Solutions:**
1. **Check project name** - Must match exactly (case sensitive)
2. **Verify work item types** - Use types that exist in your project
3. **Check work item states** - Items in 'Closed'/'Done' are excluded
4. **Test WIQL query manually** in Azure DevOps

```sql
-- Test query in Azure DevOps > Queries
SELECT [System.Id], [System.Title] 
FROM WorkItems 
WHERE [System.TeamProject] = 'YourProject' 
AND [System.WorkItemType] IN ('User Story', 'Product Backlog Item')
AND [System.State] NOT IN ('Closed', 'Done', 'Removed')
```

### **Problem: Copilot authentication fails**
**Error:** `❌ Copilot authentication test failed`
**Solutions:**
1. **Check Copilot subscription** - Must be active
2. **Verify token in variable group** - Check 'copilot-credentials'
3. **Test token locally**:
```bash
export GITHUB_TOKEN="your_token"
echo "Hello" | copilot
```

### **Problem: Pipeline permissions**
**Error:** `403 Forbidden` or access denied
**Solutions:**
1. **Grant pipeline permissions**:
   - Go to Project Settings > Pipelines > Settings
   - Enable "Limit job authorization scope to current project for non-release pipelines"
2. **Add build service permissions**:
   - Go to Project Settings > Repositories > Security
   - Add "[Project] Build Service" with Contribute permissions

### **Problem: Analysis timeout**
**Error:** `⚠️ Analysis failed for #ID, using fallback`
**Solutions:**
1. **Reduce batch size** - Set `analyzeTop: 5` for testing
2. **Increase timeout** - Edit `COPILOT_TIMEOUT: 90` in pipeline
3. **Try during off-peak hours** - GitHub Copilot may be busy
4. **Check work item complexity** - Very long descriptions may timeout

---

## 📊 **Quality Issues**

### **Problem: Poor analysis quality**
**Symptoms:** Generic responses, no specific recommendations
**Solutions:**
1. **Improve work item quality first**:
   - Add detailed descriptions
   - Include clear acceptance criteria
   - Specify business value
2. **Customize analysis prompts** for your domain
3. **Use 'Comprehensive' analysis mode** for better insights

### **Problem: Inconsistent scoring**
**Symptoms:** Similar items get very different scores
**Solutions:**
1. **Use consistent work item templates**
2. **Standardize acceptance criteria format**
3. **Run analysis multiple times** and average results
4. **Focus on trends** rather than absolute scores

---

## 🔧 **Technical Issues**

### **Problem: Node.js installation fails**
**Error:** Package installation errors
**Solutions:**
```bash
# Manual Node.js setup
curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash -
sudo apt-get install -y nodejs

# Verify
node --version  # Should be v22+
npm --version
```

### **Problem: Artifacts not publishing**
**Error:** Reports missing from pipeline artifacts
**Solutions:**
1. **Check file paths** - Verify files are created in `$(Agent.TempDirectory)`
2. **Use `condition: always()`** in PublishBuildArtifacts tasks
3. **Debug file creation**:
```yaml
- script: |
    ls -la $(Agent.TempDirectory)
    cat $(Agent.TempDirectory)/analysis-report.md
  displayName: 'Debug Files'
```

### **Problem: YAML syntax errors**
**Error:** Pipeline won't validate
**Solutions:**
1. **Use YAML validator**: https://yamllint.com
2. **Check indentation** - Use spaces, not tabs
3. **Escape special characters** in strings
4. **Use pipeline editor** in Azure DevOps for validation

---

## 📋 **Configuration Issues**

### **Problem: Wrong work item types**
**Error:** No items match the specified types
**Solutions:**
```bash
# Check available work item types
az boards work-item show --organization https://dev.azure.com/YourOrg --project YourProject --id 1 --query "fields.'System.WorkItemType'"

# Common work item types:
# - User Story
# - Product Backlog Item  
# - Epic
# - Feature
# - Task
# - Bug
```

### **Problem: Area path restrictions**
**Symptoms:** Missing items you expect to see
**Solutions:**
1. **Add area path filter** to WIQL:
```sql
AND [System.AreaPath] UNDER 'YourProject\YourTeam'
```
2. **Check team permissions** - Verify access to work items
3. **Use broader query** initially, then filter

---

## 🚀 **Performance Issues**

### **Problem: Pipeline runs too slow**
**Symptoms:** Takes >10 minutes for small backlogs
**Solutions:**
1. **Reduce analysis scope**:
   - `analyzeTop: 10` max for testing
   - Focus on one work item type
2. **Optimize timeouts**:
```yaml
variables:
  - name: COPILOT_TIMEOUT
    value: 45  # Reduce from 60
  - name: API_TIMEOUT  
    value: 20  # Reduce from 30
```

### **Problem: Memory issues**
**Error:** Agent runs out of memory
**Solutions:**
1. **Process items in smaller batches**
2. **Clean up temporary files**:
```bash
# Add to pipeline
rm -f temp-*.json *.tmp
```

---

## 🆘 **Getting Help**

### **Debug Mode**
Enable verbose logging by adding to your pipeline:
```yaml
variables:
  - name: system.debug
    value: true
```

### **Local Testing**
Test Copilot CLI locally before running pipeline:
```bash
# Set environment
export GITHUB_TOKEN="your_token"

# Test basic functionality
echo "Rate this user story quality 1-10: As a user, I want to login" | copilot

# Test with work item data
echo "Analyze: Title: User Login, Description: Basic login functionality" | copilot
```

### **Check System Status**
- **GitHub Copilot Status**: https://www.githubstatus.com
- **Azure DevOps Status**: https://status.dev.azure.com
- **Azure CLI Issues**: https://github.com/Azure/azure-cli/issues

### **Common Diagnostic Commands**
```bash
# Check Azure CLI
az --version
az account show

# Check project access
az devops project show --project YourProject --organization https://dev.azure.com/YourOrg

# Test variable group
az pipelines variable-group list --organization https://dev.azure.com/YourOrg --project YourProject

# Check pipeline permissions
az pipelines show --name "Backlog Analyzer" --organization https://dev.azure.com/YourOrg --project YourProject
```

---

**🎯 Still having issues? Check the pipeline logs for specific error messages and search for the exact error text in this guide.**