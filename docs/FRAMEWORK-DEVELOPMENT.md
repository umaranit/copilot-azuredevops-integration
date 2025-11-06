# Framework Development Guide

This guide explains how to extend the GitHub Copilot CLI Integration for Azure DevOps framework with new use cases and capabilities.

## Framework Philosophy

The framework is built on these principles:

1. **Modular Design**: Reusable components that can be combined in different ways
2. **Enterprise Ready**: Built-in compliance, governance, and security features
3. **Individual License Amplification**: Maximize value from personal Copilot subscriptions
4. **No Migration Pressure**: Enhance Azure DevOps without requiring platform changes

## Core Architecture

### Components (`/core/components/`)

Each component is a standalone, parameterized template that handles a specific responsibility:

- **Input Validation**: Ensures proper configuration and credentials
- **Error Handling**: Graceful failure with actionable error messages
- **Logging**: Comprehensive activity logs for troubleshooting
- **Security**: Secure credential handling and API access

#### Available Components

| Component | Purpose | Key Parameters |
|-----------|---------|----------------|
| `setup-copilot-template.yml` | GitHub Copilot CLI authentication and configuration | `copilotModel`, `rateLimitStrategy`, `timeout` |
| `fetch-workitems-template.yml` | Azure DevOps work item retrieval and processing | `azureDevOpsOrg`, `project`, `queryScope` |
| `ai-analysis-template.yml` | Copilot-powered analysis and insight generation | `analysisType`, `contextWindow`, `outputFormat` |
| `reporting-template.yml` | Report generation and formatting | `outputFormat`, `includeMetrics`, `recipients` |

### Workflows (`/core/workflows/`)

Pre-composed workflows that combine multiple components for common scenarios:

- **`basic-analysis.yml`**: Simple analysis for small teams (< 50 work items)
- **`standard-analysis.yml`**: Full-featured analysis with reporting (< 200 work items)
- **`enterprise-analysis.yml`**: Enterprise-grade with compliance and governance

## Creating New Use Cases

### 1. Use Case Structure

```
use-cases/your-use-case/
├── README.md              # Use case documentation
├── workflow.yml           # Main workflow (or multiple .yml files)
├── config/
│   ├── template.yml       # Configuration template
│   └── examples/          # Example configurations
└── samples/
    ├── input-example.json # Sample input data
    └── output-example.md  # Sample output report
```

### 2. Workflow Development

Start with a pre-composed workflow and customize:

```yaml
# use-cases/my-use-case/workflow.yml
name: 'My Custom Use Case'
trigger: none

parameters:
  - name: analysisScope
    displayName: 'Analysis Scope'
    type: string
    default: 'current-sprint'
    values:
      - 'current-sprint'
      - 'next-sprint'
      - 'full-backlog'

variables:
  - group: 'azure-devops-connection'
  - group: 'github-copilot-config'

stages:
  - stage: Setup
    jobs:
      - job: ConfigureCopilot
        steps:
          - template: ../../core/components/setup-copilot-template.yml
            parameters:
              copilotModel: $(COPILOT_MODEL)
              rateLimitStrategy: 'conservative'
              
  - stage: DataCollection  
    jobs:
      - job: FetchData
        steps:
          - template: ../../core/components/fetch-workitems-template.yml
            parameters:
              azureDevOpsOrg: $(ADO_ORG)
              project: $(ADO_PROJECT)
              queryScope: ${{ parameters.analysisScope }}
              
  - stage: Analysis
    jobs:
      - job: AIAnalysis
        steps:
          - template: ../../core/components/ai-analysis-template.yml
            parameters:
              analysisType: 'custom-analysis'
              prompt: 'Analyze the work items for...'
              
  - stage: Reporting
    jobs:
      - job: GenerateReport
        steps:
          - template: ../../core/components/reporting-template.yml
            parameters:
              outputFormat: 'markdown'
              includeCharts: true
```

### 3. Configuration Templates

Create configuration templates for different team sizes and scenarios:

```yaml
# use-cases/my-use-case/config/template.yml
# Configuration template for My Custom Use Case

# Azure DevOps Connection
azureDevOps:
  organization: "$(ADO_ORG)"
  project: "$(ADO_PROJECT)"
  personalAccessToken: "$(ADO_PAT)"

# Analysis Parameters
analysis:
  scope: "current-sprint"
  maxItems: 100
  includeClosedItems: false
  analysisDepth: "standard"

# Copilot Configuration
copilot:
  model: "gpt-4"
  rateLimitStrategy: "conservative"
  timeout: 300
  
# Reporting Options
reporting:
  format: "markdown"
  includeCharts: true
  emailRecipients: []
  
# Custom Parameters
custom:
  focusAreas:
    - "quality"
    - "estimation"
    - "dependencies"
```

### 4. Documentation Standards

Each use case should include comprehensive documentation:

```markdown
# Use Case Name

## Overview
Brief description of the use case and its business value.

## Target Audience
Who should use this use case and when.

## Prerequisites
- Individual GitHub Copilot license
- Azure DevOps access
- Specific permissions or configurations

## Quick Start
Step-by-step instructions for basic usage.

## Configuration
Detailed parameter explanations and examples.

## Sample Output
Example of the generated insights and reports.

## Business Value
Quantified benefits and ROI considerations.

## Troubleshooting
Common issues and solutions.
```

## Component Development

### Creating New Components

1. **Identify the Responsibility**: Each component should have a single, clear purpose
2. **Define Parameters**: Make components configurable with sensible defaults
3. **Implement Error Handling**: Graceful failures with actionable messages
4. **Add Logging**: Comprehensive activity tracking
5. **Test Thoroughly**: Validate with different parameter combinations

### Component Template

```yaml
# core/components/my-new-component.yml
parameters:
  - name: requiredParam
    type: string
  - name: optionalParam
    type: string
    default: 'default-value'

steps:
  - task: PowerShell@2
    displayName: 'My Component - Setup'
    inputs:
      targetType: 'inline'
      script: |
        Write-Host "Starting component with parameters:"
        Write-Host "Required: ${{ parameters.requiredParam }}"
        Write-Host "Optional: ${{ parameters.optionalParam }}"
        
        # Input validation
        if ([string]::IsNullOrEmpty("${{ parameters.requiredParam }}")) {
          Write-Error "Required parameter cannot be empty"
          exit 1
        }
        
        # Component logic here
        try {
          # Main functionality
          Write-Host "Component completed successfully"
        }
        catch {
          Write-Error "Component failed: $_"
          exit 1
        }
```

## Best Practices

### Security
- Never hardcode credentials in workflows
- Use Azure DevOps variable groups for sensitive data
- Implement least-privilege access patterns
- Audit all API calls and data access

### Performance
- Implement intelligent rate limiting for Copilot CLI
- Cache Azure DevOps data when possible
- Optimize prompt engineering for faster responses
- Use pagination for large datasets

### Maintainability
- Follow consistent naming conventions
- Document all parameters and their impacts
- Version your workflows and components
- Implement comprehensive error handling

### Testing
- Test with different Azure DevOps configurations
- Validate with various team sizes and data volumes
- Test error scenarios and recovery paths
- Verify compliance with enterprise policies

## Advanced Patterns

### Conditional Logic
```yaml
- ${{ if eq(parameters.environment, 'production') }}:
  - template: ../../core/components/enterprise-validation.yml
```

### Dynamic Parameters
```yaml
- task: PowerShell@2
  inputs:
    script: |
      $config = Get-Content "config.json" | ConvertFrom-Json
      Write-Host "##vso[task.setvariable variable=dynamicParam]$($config.value)"
```

### Multi-Stage Workflows
```yaml
stages:
  - stage: Validation
    condition: always()
  - stage: Analysis  
    condition: succeeded('Validation')
  - stage: Reporting
    condition: succeeded('Analysis')
```

## Contributing Guidelines

1. **Follow the Structure**: Use the established directory patterns
2. **Test Thoroughly**: Validate with real Azure DevOps data
3. **Document Everything**: Include comprehensive README files
4. **Security First**: Review all credential handling
5. **Performance Conscious**: Consider rate limits and API quotas

## Framework Roadmap

### Current Features
- ✅ Backlog analysis and optimization
- ✅ Modular component architecture
- ✅ Enterprise-ready workflows
- ✅ Individual license amplification

### Planned Features
- 🔄 Code review insights and automation
- 🔄 Sprint retrospective AI analysis
- 🔄 Release readiness assessment
- 🔄 Custom prompt templates
- 🔄 Multi-organization support
- 🔄 Advanced analytics dashboard

### Community Contributions Welcome
- New use case implementations
- Component enhancements
- Documentation improvements
- Best practice sharing
- Enterprise deployment guides

For questions or contributions, see the [main README](../README.md) or open an issue in the repository.