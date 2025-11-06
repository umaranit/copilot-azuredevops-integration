# Core Framework Components

This directory contains the reusable components and workflows that form the foundation of the GitHub Copilot CLI Integration for Azure DevOps framework.

## Components (`/components`)

These are modular, reusable templates that can be composed into different workflows:

- **`ai-analysis-template.yml`** - GitHub Copilot CLI integration for AI-powered analysis
- **`fetch-workitems-template.yml`** - Azure DevOps work items retrieval and processing
- **`reporting-template.yml`** - Report generation and formatting
- **`setup-copilot-template.yml`** - GitHub Copilot CLI authentication and configuration

## Workflows (`/workflows`)

Pre-composed workflow patterns that combine multiple components:

- **`basic-analysis.yml`** - Simple AI analysis workflow for small teams
- **`standard-analysis.yml`** - Standard workflow with full reporting capabilities
- **`enterprise-analysis.yml`** - Enterprise-grade workflow with compliance and governance

## Usage

Components are designed to be:
- **Modular**: Each component handles a specific responsibility
- **Configurable**: 30+ parameters for customization
- **Enterprise-Ready**: Built-in error handling, logging, and compliance features
- **Extensible**: Easy to combine and extend for new use cases

## Integration Patterns

```yaml
# Example: Using components in a custom workflow
steps:
  - template: core/components/setup-copilot-template.yml
    parameters:
      copilotModel: 'gpt-4'
      rateLimitStrategy: 'enterprise'
  
  - template: core/components/fetch-workitems-template.yml
    parameters:
      azureDevOpsOrg: $(ADO_ORG)
      project: $(ADO_PROJECT)
  
  - template: core/components/ai-analysis-template.yml
    parameters:
      analysisType: 'custom'
      outputFormat: 'markdown'
```