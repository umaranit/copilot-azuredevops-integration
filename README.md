# GitHub Copilot + Azure DevOps Backlog Analyzer

AI-powered backlog analysis using GitHub Copilot CLI integrated with Azure DevOps workflows.

## 💡 **Why This Matters**

### **Maximize Your Existing Copilot Investment**
- Transform individual Copilot seats into **team-wide productivity gains**
- Scale AI benefits beyond IDE usage to **entire development workflows** 
- Prove measurable AI ROI before making bigger platform decisions

### **Enterprise AI Without Migration Pressure**
- Work within your existing Azure DevOps processes - **no platform changes required**
- Leverage GitHub Copilot CLI for **automated backlog analysis and quality improvement**
- Demonstrate AI value to stakeholders through **concrete work item improvements**

### **CLI Agent Advantages**
- **Batch processing**: Analyze hundreds of work items automatically vs. one-by-one in IDE
- **Consistent analysis**: Same quality standards applied across all backlog items
- **Team scalability**: One pipeline serves entire development team
- **Measurable outcomes**: Generate reports showing tangible quality improvements

## 🚀 **2-Minute Setup**

### **Option 1: Automated Setup**
```powershell
# Run this command and you're done!
.\setup\deploy.ps1 -Organization "yourorg" -Project "yourproject" -GitHubToken "ghp_xxxx"
```

### **Option 2: Manual Setup**
1. **Create variable group** in Azure DevOps: `copilot-credentials` with `GITHUB_TOKEN`
2. **Import pipeline**: Upload `backlog-analyzer.yml` to Azure DevOps
3. **Run pipeline**: Set your project name and go!

## 🎯 **What You Get**

- ✅ **AI-powered backlog analysis** using GitHub Copilot CLI
- ✅ **INVEST quality scoring** for User Stories  
- ✅ **Technical recommendations** for implementation
- ✅ **Business value assessment** for prioritization
- ✅ **Detailed reports** with actionable insights

## 📋 **Requirements**

- Azure DevOps project with work items
- GitHub account with Copilot access
- GitHub Personal Access Token ([create here](https://github.com/settings/tokens))

## 📊 **Sample Analysis Output**

```markdown
# Work Item #12345: User Authentication System

**Quality Score: 7/10** ✅ Good Quality

### INVEST Analysis
- ✅ Independent: Can be developed standalone
- ✅ Negotiable: Flexible acceptance criteria  
- ✅ Valuable: Clear business value for security
- ⚠️ Estimable: Story points needed
- ❌ Small: Consider splitting into smaller stories
- ✅ Testable: Clear test scenarios defined

### 🎯 Top Recommendations
1. Split into: "Login UI", "Auth API", "Password Reset"
2. Add specific performance requirements (< 2sec login)
3. Include security testing scenarios

### 🔧 Technical Implementation
- **Architecture**: OAuth 2.0 + JWT tokens recommended
- **Security**: Rate limiting, secure password storage required
- **Testing**: Unit tests, integration tests, security scanning
```

## ⚙️ **Customization Options**

When running the pipeline, you can customize:

| **Parameter** | **Default** | **Options** |
|---------------|-------------|-------------|
| **Project Name** | "Parts Unlimited" | Your Azure DevOps project |
| **Items to Analyze** | 5 | 5, 10, 15, 20, 25, 30 |
| **Analysis Mode** | "standard" | basic, standard, detailed, governance |
| **Work Item Types** | "User Story,Product Backlog Item" | Any work item types in your project |

---

**🎯 Ready to improve your backlog quality? Run the setup command above!**