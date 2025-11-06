# Azure DevOps Backlog Analyzer

> **Part of the GitHub Copilot CLI Integration for Azure DevOps Framework**

AI-powered backlog analysis using GitHub Copilot CLI to provide intelligent insights on Azure DevOps work items.

## Overview

This use case demonstrates how to leverage individual GitHub Copilot licenses to enhance Azure DevOps workflows without requiring enterprise GitHub migration. It provides:

- **Sprint Readiness Assessment**: AI evaluation of work items for sprint planning
- **Priority Optimization**: Intelligent recommendations for backlog prioritization  
- **Technical Debt Analysis**: Identification of maintenance and refactoring needs
- **Cross-Team Dependencies**: Analysis of work item relationships and blockers

## Target Audience

- **Product Managers**: Sprint planning and backlog grooming insights
- **Engineering Leaders**: Technical debt and capacity planning
- **Scrum Masters**: Sprint readiness and dependency management
- **Development Teams**: Work item clarity and estimation support

## Quick Start

### Prerequisites

- Azure DevOps organization access
- Individual GitHub Copilot license
- Azure DevOps personal access token
- Node.js v22+ and npm v10+ (for Copilot CLI installation)

### Basic Usage

1. **Configure your environment**:
   ```bash
   # Set up Azure DevOps connection
   export ADO_ORG="your-organization"
   export ADO_PROJECT="your-project" 
   export ADO_PAT="your-personal-access-token"
   
   # Install GitHub Copilot CLI globally
   npm install -g @github/copilot
   
   # Set GitHub token for authentication
   export GITHUB_TOKEN="your-github-pat-token"
   
   # Test the installation
   copilot
   ```

2. **Run the analysis**:
   ```bash
   # Using the improved workflow
   az pipelines run --name "backlog-analyzer-IMPROVED" 
   ```

3. **Review the insights**:
   - Check the generated analysis report
   - Review sprint readiness recommendations
   - Implement suggested priority changes

## Configuration

### Basic Configuration (`config/template.yml`)

```yaml
# Azure DevOps Settings
azureDevOps:
  organization: "$(ADO_ORG)"
  project: "$(ADO_PROJECT)"
  personalAccessToken: "$(ADO_PAT)"

# Analysis Parameters
analysis:
  sprintCapacity: 80
  priorityThreshold: 3
  includeClosedItems: false
  analysisDepth: "standard"

# Copilot Settings
copilot:
  cliExtension: "github/gh-copilot"
  rateLimitStrategy: "conservative"
  timeout: 300
```

### Advanced Configuration

For enterprise deployments with multiple teams, see [`config/examples/multi-team.yml`](./config/examples/multi-team.yml).

## Framework Integration

This use case demonstrates the framework's core capabilities:

```yaml
# Workflow composition using core components
steps:
  - template: ../../core/components/setup-copilot-template.yml
    parameters:
      copilotModel: 'gpt-4'
      rateLimitStrategy: 'enterprise'
      
  - template: ../../core/components/fetch-workitems-template.yml
    parameters:
      azureDevOpsOrg: $(ADO_ORG)
      project: $(ADO_PROJECT)
      queryScope: 'current-iteration'
      
  - template: ../../core/components/ai-analysis-template.yml
    parameters:
      analysisType: 'backlog-optimization'
      contextWindow: 'large'
      
  - template: ../../core/components/reporting-template.yml
    parameters:
      outputFormat: 'markdown'
      includeMetrics: true
```

## Sample Output

See [`samples/sample-analysis-report.md`](./samples/sample-analysis-report.md) for an example of the generated insights.

## Business Value

- **Improved Sprint Planning**: AI-driven sprint readiness assessment
- **Enhanced Productivity**: Automated backlog analysis saves 2-4 hours per sprint
- **Better Prioritization**: Data-driven priority recommendations
- **Risk Mitigation**: Early identification of blockers and dependencies

## Compliance & Governance

This use case maintains Azure DevOps governance while adding AI capabilities:
- Respects existing access controls and permissions
- Maintains audit trail in Azure DevOps
- No data migration or process disruption required
- Complies with enterprise security policies

## Troubleshooting

For common issues:
- Check GitHub token has Copilot access permissions
- Verify Azure DevOps project name and permissions
- Ensure Node.js v22+ is installed for Copilot CLI
- Review pipeline logs for specific error messages

## Contributing

To extend this use case or create variations:
1. Modify the configuration templates
2. Adjust the AI analysis prompts
3. Customize the reporting format
4. Test with your Azure DevOps data

For detailed guidance, see the [Framework Development Guide](../../docs/FRAMEWORK-DEVELOPMENT.md).