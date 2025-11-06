# 🚀 Real-World Usage Scenarios for `setup.ps1`

The `setup.ps1` script transforms the Backlog Analyzer from a technical demo into a production-ready organizational asset. This document outlines practical scenarios where teams and organizations can leverage the automated setup for maximum impact.

## 📋 Table of Contents
- [Quick Reference](#-quick-reference)
- [Individual Team Scenarios](#-individual-team-scenarios)
- [Multi-Team Deployments](#-multi-team-deployments)
- [Enterprise Rollouts](#-enterprise-rollouts)
- [Specialized Use Cases](#-specialized-use-cases)
- [Troubleshooting Scenarios](#-troubleshooting-scenarios)

---

## 🎯 Quick Reference

| Scenario | Command | Time | Complexity |
|----------|---------|------|------------|
| **Single Team** | `.\pipeline\setup.ps1 -Organization "..." -Project "..." -GitHubToken "..."` | 2-5 min | 🟢 Simple |
| **Multiple Teams** | Foreach loop with CSV | 10-15 min | 🟡 Medium |
| **Enterprise** | Automated script with templates | 30-60 min | 🟠 Advanced |

---

## 👥 Individual Team Scenarios

### 🏪 **Scenario 1: E-Commerce Product Team**

**Context**: Medium-sized product team (8 developers) wants to improve sprint planning with AI insights.

**Team Profile**:
- 📊 Backlog size: ~50 work items
- 🎯 Goal: Weekly backlog health reports
- 👤 Executor: Product Manager (non-technical)
- ⏰ Timeline: Needs results before next sprint planning

**Command**:
```powershell
.\pipeline\setup.ps1 `
    -Organization "https://dev.azure.com/ContosoRetail" `
    -Project "E-Commerce-Platform" `
    -GitHubToken "ghp_xxxxxxxxxxxx" `
    -Template "standard"
```

**Expected Outcome**:
- ✅ Weekly automated analysis every Monday at 9 AM
- ✅ Teams notifications with quality scores
- ✅ Executive summary for stakeholders
- ✅ INVEST principle compliance tracking

---

### 🏦 **Scenario 2: Banking Compliance Team**

**Context**: Highly regulated environment requiring detailed audit trails and governance.

**Team Profile**:
- 📊 Backlog size: ~30 compliance-focused items
- 🎯 Goal: Risk assessment and quality validation
- 👤 Executor: DevOps Engineer
- ⏰ Timeline: Quarterly compliance reviews

**Command**:
```powershell
.\pipeline\setup.ps1 `
    -Organization "https://dev.azure.com/SecureBank" `
    -Project "Compliance-Automation" `
    -GitHubToken "ghp_xxxxxxxxxxxx" `
    -Template "enterprise" `
    -Verbose
```

**Configuration Customization**:
```yaml
# Additional parameters in config/examples/compliance.yml
parameters:
  analysisMode: 'governance'
  requireApproval: true
  auditTrail: true
  complianceFramework: 'SOX,PCI-DSS'
```

---

### 🚀 **Scenario 3: Startup MVP Team**

**Context**: Fast-moving startup needing quick insights without DevOps overhead.

**Team Profile**:
- 📊 Backlog size: ~15 MVP features
- 🎯 Goal: Fast iteration and quality gates
- 👤 Executor: Tech Lead
- ⏰ Timeline: Deploy today, analyze tomorrow

**Command**:
```powershell
.\pipeline\setup.ps1 `
    -Organization "https://dev.azure.com/TechStartup" `
    -Project "MVP-Development" `
    -GitHubToken "ghp_xxxxxxxxxxxx" `
    -Template "basic" `
    -QuickStart
```

**Benefits**:
- ⚡ Minimal configuration overhead
- 🎯 Focus on feature quality metrics
- 📱 Slack/Teams integration for immediate feedback

---

## 🏢 Multi-Team Deployments

### 🌐 **Scenario 4: Digital Agency (Multiple Client Projects)**

**Context**: Agency managing 5 client projects simultaneously, each with different requirements.

**Team Profile**:
- 📊 Projects: 5 different clients
- 🎯 Goal: Standardized quality reporting across clients
- 👤 Executor: Technical Operations Manager
- ⏰ Timeline: Deploy across all projects in one session

**Automated Deployment Script**:
```powershell
# clients.csv contains: ProjectName,Organization,Template,Schedule
$clients = Import-Csv ".\config\clients.csv"

foreach ($client in $clients) {
    Write-Host "🚀 Deploying for client: $($client.ProjectName)" -ForegroundColor Green
    
    .\pipeline\setup.ps1 `
        -Organization $client.Organization `
        -Project $client.ProjectName `
        -GitHubToken $env:GITHUB_TOKEN `
        -Template $client.Template `
        -Schedule $client.Schedule
    
    Start-Sleep -Seconds 10  # Rate limiting
}
```

**Client Configuration Examples**:
| Client | Template | Schedule | Focus Area |
|--------|----------|----------|------------|
| **RetailCorp** | standard | Weekly | Feature delivery |
| **HealthTech** | enterprise | Daily | Compliance |
| **FinanceApp** | enterprise | Bi-weekly | Security |
| **StartupX** | basic | Manual | MVP features |
| **Enterprise** | enterprise | Daily | Governance |

---

### 🏭 **Scenario 5: Manufacturing Company (Product Lines)**

**Context**: Large manufacturer with multiple product lines, each having separate development teams.

**Team Profile**:
- 📊 Product lines: 8 different divisions
- 🎯 Goal: Cross-product quality benchmarking
- 👤 Executor: IT Operations Team
- ⏰ Timeline: Quarterly rollout with centralized reporting

**Enterprise Deployment**:
```powershell
# Product lines with different configurations
$productLines = @(
    @{Name="Automotive"; Org="https://dev.azure.com/ManufCorp"; Template="enterprise"; Priority="high"},
    @{Name="Aerospace"; Org="https://dev.azure.com/ManufCorp"; Template="enterprise"; Priority="critical"},
    @{Name="Consumer"; Org="https://dev.azure.com/ManufCorp"; Template="standard"; Priority="medium"},
    @{Name="Industrial"; Org="https://dev.azure.com/ManufCorp"; Template="standard"; Priority="high"}
)

foreach ($line in $productLines) {
    .\pipeline\setup.ps1 `
        -Organization $line.Org `
        -Project $line.Name `
        -GitHubToken $env:GITHUB_TOKEN `
        -Template $line.Template `
        -BusinessUnit $line.Name `
        -Priority $line.Priority
}
```

---

## 🏛️ Enterprise Rollouts

### 🌍 **Scenario 6: Global Technology Company**

**Context**: Fortune 500 company with 50+ development teams across multiple regions.

**Scale**:
- 👥 Teams: 50+ development teams
- 🌐 Regions: North America, Europe, Asia-Pacific
- 📊 Projects: 200+ active projects
- 🎯 Goal: Standardized AI-powered backlog analysis globally

**Phase 1: Pilot Deployment (5 teams)**
```powershell
# Pilot teams for initial validation
$pilotTeams = @("TeamA-US", "TeamB-EU", "TeamC-APAC", "TeamD-US", "TeamE-EU")

foreach ($team in $pilotTeams) {
    .\pipeline\setup.ps1 `
        -Organization "https://dev.azure.com/GlobalTech" `
        -Project $team `
        -GitHubToken $env:GITHUB_TOKEN `
        -Template "enterprise" `
        -Phase "pilot" `
        -Monitoring $true
}
```

**Phase 2: Regional Rollout**
```powershell
# Region-based deployment with specific configurations
$regions = @{
    "NorthAmerica" = @{Teams=@("Team1","Team2","Team3"); Timezone="EST"; Compliance="SOX"}
    "Europe" = @{Teams=@("TeamEU1","TeamEU2"); Timezone="CET"; Compliance="GDPR"}
    "AsiaPacific" = @{Teams=@("TeamAPAC1","TeamAPAC2"); Timezone="JST"; Compliance="Local"}
}

foreach ($region in $regions.Keys) {
    foreach ($team in $regions[$region].Teams) {
        .\pipeline\setup.ps1 `
            -Organization "https://dev.azure.com/GlobalTech" `
            -Project $team `
            -GitHubToken $env:GITHUB_TOKEN `
            -Template "enterprise" `
            -Region $region `
            -Timezone $regions[$region].Timezone `
            -Compliance $regions[$region].Compliance
    }
}
```

**Phase 3: Full Enterprise Deployment**
```powershell
# Automated deployment from HR/IT systems
$teams = Get-AzureDevOpsProjects -Organization "GlobalTech" | Where-Object {$_.Category -eq "Development"}

$teams | ForEach-Object -Parallel {
    .\pipeline\setup.ps1 `
        -Organization "https://dev.azure.com/GlobalTech" `
        -Project $_.Name `
        -GitHubToken $env:GITHUB_TOKEN `
        -Template "enterprise" `
        -AutoDetectConfig $true `
        -CentralizedReporting $true
} -ThrottleLimit 5
```

---

## 🎯 Specialized Use Cases

### 🔒 **Scenario 7: Government Agency (High Security)**

**Context**: Government agency with strict security requirements and air-gapped environments.

**Requirements**:
- 🔐 No external API calls during analysis
- 📋 Detailed audit logs
- 🛡️ Encrypted variable storage
- 👤 User attribution for all operations

**Command**:
```powershell
.\pipeline\setup.ps1 `
    -Organization "https://dev.azure.us/GovAgency" `
    -Project "SecureProject" `
    -GitHubToken $env:GITHUB_TOKEN `
    -Template "government" `
    -SecurityLevel "high" `
    -AuditMode $true `
    -EncryptionRequired $true `
    -AirGapped $true
```

**Custom Configuration**:
```yaml
# government-template.yml
parameters:
  securityLevel: 'high'
  auditAllOperations: true
  encryptAllVariables: true
  requireApprovalWorkflow: true
  maxBacklogSize: 25  # Security limitation
  allowedAnalysisHours: '09:00-17:00'  # Business hours only
```

---

### 🎓 **Scenario 8: Educational Institution (Multiple Courses)**

**Context**: University with multiple software engineering courses using Azure DevOps for project management.

**Scale**:
- 📚 Courses: 12 different classes
- 👨‍🎓 Students: 300+ across all courses
- 🎯 Goal: Automated grading and feedback on project management practices

**Semester Setup**:
```powershell
# courses.json contains course information
$courses = Get-Content ".\config\courses.json" | ConvertFrom-Json

foreach ($course in $courses) {
    .\pipeline\setup.ps1 `
        -Organization "https://dev.azure.com/University" `
        -Project $course.Name `
        -GitHubToken $env:GITHUB_TOKEN `
        -Template "educational" `
        -Semester $course.Semester `
        -Instructor $course.Instructor `
        -StudentCount $course.StudentCount `
        -GradingMode $true
}
```

---

### 🏥 **Scenario 9: Healthcare System (HIPAA Compliance)**

**Context**: Healthcare organization developing patient management systems with strict compliance requirements.

**Requirements**:
- 🏥 HIPAA compliance
- 🔐 PHI data protection
- 📋 FDA validation documentation
- 🛡️ Risk assessment integration

**Command**:
```powershell
.\pipeline\setup.ps1 `
    -Organization "https://dev.azure.com/HealthSystem" `
    -Project "PatientManagement" `
    -GitHubToken $env:GITHUB_TOKEN `
    -Template "healthcare" `
    -ComplianceFramework "HIPAA,FDA" `
    -DataClassification "PHI" `
    -RiskAssessment $true
```

---

## 🔧 Troubleshooting Scenarios

### 🚨 **Scenario 10: Failed Deployment Recovery**

**Context**: Setup failed due to network issues, need to resume from checkpoint.

**Command**:
```powershell
# Resume from last successful checkpoint
.\pipeline\setup.ps1 `
    -Organization "https://dev.azure.com/YourOrg" `
    -Project "YourProject" `
    -GitHubToken $env:GITHUB_TOKEN `
    -Resume $true `
    -Checkpoint "VariableGroupCreated" `
    -Verbose
```

---

### 🔄 **Scenario 11: Configuration Update**

**Context**: Need to update GitHub token or change analysis parameters without full redeployment.

**Command**:
```powershell
# Update existing configuration
.\pipeline\setup.ps1 `
    -Organization "https://dev.azure.com/YourOrg" `
    -Project "YourProject" `
    -GitHubToken $env:NEW_GITHUB_TOKEN `
    -Update $true `
    -PreserveHistory $true
```

---

### 🧹 **Scenario 12: Environment Cleanup**

**Context**: Remove all backlog analyzer components for decommissioned project.

**Command**:
```powershell
# Clean removal of all components
.\pipeline\setup.ps1 `
    -Organization "https://dev.azure.com/YourOrg" `
    -Project "OldProject" `
    -Cleanup $true `
    -RemoveVariableGroups $true `
    -RemovePipelines $true `
    -Confirm:$false
```

---

## 📊 Success Metrics by Scenario

| Scenario Type | Setup Time | Success Rate | Adoption Rate | ROI Timeline |
|---------------|------------|--------------|---------------|--------------|
| **Individual Team** | 2-5 minutes | 95% | 85% | 1 sprint |
| **Multi-Team** | 10-15 minutes | 90% | 75% | 1 month |
| **Enterprise** | 30-60 minutes | 85% | 60% | 1 quarter |
| **Specialized** | 15-30 minutes | 80% | 70% | 2 months |

---

## 🎯 Choosing the Right Scenario

### **Use Individual Team Setup When**:
- ✅ Single team deployment
- ✅ Quick proof of value needed
- ✅ Standard Azure DevOps setup
- ✅ Basic backlog analysis requirements

### **Use Multi-Team Setup When**:
- ✅ 3-10 teams with similar needs
- ✅ Standardized configuration across teams
- ✅ Centralized DevOps management
- ✅ Consistent reporting requirements

### **Use Enterprise Setup When**:
- ✅ 20+ teams across organization
- ✅ Complex compliance requirements
- ✅ Integration with existing enterprise tools
- ✅ Governance and audit needs

### **Use Specialized Setup When**:
- ✅ Unique industry requirements
- ✅ Custom compliance frameworks
- ✅ Integration with specialized tools
- ✅ Non-standard organizational structure

---

## 🚀 Getting Started

1. **Identify Your Scenario**: Match your situation to the scenarios above
2. **Prepare Prerequisites**: Ensure Azure CLI, GitHub token, and permissions
3. **Choose Template**: Select basic, standard, enterprise, or specialized
4. **Execute Setup**: Run the appropriate command for your scenario
5. **Validate Results**: Check pipeline creation and first analysis run
6. **Scale Deployment**: Expand to additional teams using learned patterns

---

*For technical support and advanced scenarios, see [TROUBLESHOOTING.md](TROUBLESHOOTING.md) or contact your DevOps team.*