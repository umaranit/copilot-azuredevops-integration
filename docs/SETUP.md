# 🚀 Setup Guide - Backlog Analyzer

Get your AI-powered backlog analysis running in **5 minutes**!

## ⚡ Quick Setup

### 1️⃣ **Clone Repository**
```bash
git clone https://github.com/your-org/azure-devops-backlog-analyzer.git
cd azure-devops-backlog-analyzer
```

### 2️⃣ **Prerequisites Check**
- ✅ **Azure DevOps**: Organization + project access
- ✅ **GitHub Copilot**: Active subscription  
- ✅ **GitHub Token**: [Create Personal Access Token](https://github.com/settings/tokens)
  - Required scopes: `read:user`, `copilot`

### 3️⃣ **One-Command Deploy**
```powershell
# Windows (PowerShell)
.\pipeline\setup.ps1 -Organization "https://dev.azure.com/YourOrg" -Project "YourProject" -GitHubToken "ghp_xxxxxxxxxxxx"
```

```bash
# Linux/Mac (Bash) 
./pipeline/setup.sh --organization "https://dev.azure.com/YourOrg" --project "YourProject" --token "ghp_xxxxxxxxxxxx"
```

### 4️⃣ **First Run**
1. Go to **Azure DevOps** → **Pipelines** → **Backlog Analyzer**
2. Click **Run Pipeline**
3. Set parameters:
   - **Number of items**: `5` (for testing)
   - **Project Name**: `YourProject`  
   - **Work Item Types**: `User Story,Product Backlog Item`
4. Click **Run** 🚀

### 5️⃣ **Get Results**
- Wait ~2-5 minutes for completion
- Go to **Artifacts** tab
- Download **backlog-analysis-report**
- Open the `.md` file to see AI analysis!

---

## 🎯 **Manual Setup** (if automated setup fails)

### **Step 1: Import Pipeline**
1. Go to **Pipelines** → **New Pipeline**
2. Choose **Azure Repos Git** or **GitHub**
3. Select your repository
4. Choose **Existing Azure Pipelines YAML file**
5. Path: `pipeline/backlog-analyzer.yml`
6. Click **Continue** → **Save**

### **Step 2: Create Variable Group**
```bash
# Using Azure CLI
az pipelines variable-group create \
  --organization https://dev.azure.com/YourOrg \
  --project YourProject \
  --name "copilot-credentials" \
  --variables GITHUB_TOKEN=ghp_your_token_here
```

**Or via Azure DevOps UI:**
1. Go to **Pipelines** → **Library** → **Variable groups**
2. Click **+ Variable group**
3. Name: `copilot-credentials`
4. Add variable:
   - **Name**: `GITHUB_TOKEN`
   - **Value**: `ghp_your_token_here`
   - ✅ **Keep this value secret**
5. Click **Save**

### **Step 3: Update Pipeline Variables**
Edit `pipeline/backlog-analyzer.yml` and change:
```yaml
parameters:
  - name: projectName
    default: 'YourProject'  # ← Change this to your project name
```

---

## ⚙️ **Configuration Options**

### **Basic Configuration**
```yaml
# For small teams (5-10 work items)
parameters:
  - name: analyzeTop
    default: 10
  - name: workItemTypes
    default: 'User Story,Task'
```

### **Enterprise Configuration**  
```yaml
# For larger teams (20+ work items)
parameters:
  - name: analyzeTop
    default: 25
  - name: workItemTypes
    default: 'Epic,Feature,User Story'
  - name: analysisMode
    default: 'Comprehensive'
```

### **Custom Analysis Focus**
```yaml
parameters:
  - name: analysisMode
    values:
      - 'Quality'        # INVEST framework + quality scores
      - 'Technical'      # Technical feasibility focus
      - 'Business'       # Business value focus  
      - 'Comprehensive'  # All aspects
```

---

## 🔧 **Troubleshooting**

### **Problem: Pipeline fails at authentication**
**Solution:**
1. Check GitHub token is valid: https://github.com/settings/tokens
2. Ensure token has Copilot access
3. Verify variable group name is `copilot-credentials`

### **Problem: No work items found**
**Solution:**
1. Check project name matches exactly (case sensitive)
2. Verify work item types exist in your project
3. Ensure items are not in `Closed`/`Done`/`Removed` states

### **Problem: Copilot analysis timeout**
**Solution:**
1. Reduce `analyzeTop` parameter (try 3-5 items)
2. Check GitHub Copilot subscription is active
3. Try running during non-peak hours

### **Problem: Pipeline permissions**
**Solution:**
```bash
# Grant pipeline access to Azure DevOps APIs
az devops security permission namespace show --namespace-id 83e28ad4-2d72-4ceb-97b0-c7726d5502c3
```

---

## 📚 **Next Steps**

### **Immediate Actions**
1. ✅ Run first analysis with `analyzeTop: 5`
2. ✅ Review generated report 
3. ✅ Share results with your team
4. ✅ Schedule regular backlog reviews

### **Advanced Setup**
- **Scheduled Triggers**: Set up weekly/monthly analysis
- **Quality Gates**: Integrate with PR validation
- **Dashboards**: Connect to Power BI/Grafana
- **Notifications**: Add Teams/Slack alerts

### **Customization**
- **WIQL Queries**: Filter by area paths, iterations, tags
- **Analysis Prompts**: Customize for your domain/context
- **Report Templates**: Modify output format
- **Integration**: Connect to external tools

---

## 🤝 **Support**

**Having Issues?**
1. Check [TROUBLESHOOTING.md](TROUBLESHOOTING.md) for common problems
2. Review pipeline logs for error details
3. Test locally with `pipeline/dev-helper.ps1`
4. Open an issue with pipeline logs

**Success?**
- ⭐ Star the repository if helpful!
- 📢 Share with your organization  
- 🤝 Contribute improvements back

---

**🎉 You're now ready to analyze your backlog with AI! Your first insights are just one pipeline run away.**