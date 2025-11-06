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

## 🚀 **Setup Instructions**

### **Step 1: Create Variable Group**



1. Go to your Azure DevOps project
2. Navigate to **Pipelines** → **Library** → **Variable groups**
3. Click **+ Variable group**
4. Name: `copilot-credentials`
5. Add variable: `GITHUB_TOKEN` with your [GitHub Personal Access Token](Refer  https://github.com/github/copilot-cli for creating token)
6. Save the variable group

### **Step 2: Create Pipeline**
1. Go to **Pipelines** → **Pipelines** → **New pipeline**
2. Choose **Azure Repos Git** (or your preferred source)
3. Select **Existing Azure Pipelines YAML file**
4. Choose `backlog-analyzer.yml`
5. **Save & Run**

### **Step 3: Configure & Run**
Set these parameters when running:
- **Project Name**: Your Azure DevOps project name
- **Items to Analyze**: Start with 5-10 for testing
- **Analysis Mode**: `standard` (recommended)
- **Work Item Types**: `User Story,Product Backlog Item`

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
