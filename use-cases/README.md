# Use Cases

This directory contains practical implementations that demonstrate the framework's capabilities across different Azure DevOps scenarios.

## Available Use Cases

### 🎯 Backlog Analyzer (`/backlog-analyzer`)
**Status**: Production Ready  
**Target Audience**: Product Managers, Engineering Leaders  

Leverages GitHub Copilot CLI to provide AI-powered insights on Azure DevOps backlogs:
- Sprint readiness assessment
- Work item priority optimization
- Technical debt identification
- Cross-team dependency analysis

[View Documentation](./backlog-analyzer/README.md)

---

## Planned Use Cases

### 🔍 Code Review Insights (`/code-review-insights`)
**Status**: Planned  
**Target Audience**: Development Teams, Tech Leads  

AI-powered analysis of pull requests and code review patterns:
- Review quality assessment
- Knowledge transfer opportunities
- Code complexity analysis
- Best practice recommendations

### 📊 Sprint Retrospectives (`/sprint-retrospectives`)
**Status**: Planned  
**Target Audience**: Scrum Masters, Team Leads  

Automated retrospective insights from sprint data:
- Velocity trend analysis
- Blocker pattern identification
- Team collaboration metrics
- Improvement opportunity suggestions

### 🚀 Release Readiness (`/release-readiness`)
**Status**: Planned  
**Target Audience**: Release Managers, DevOps Engineers  

AI-driven release readiness assessment:
- Feature completion analysis
- Risk assessment
- Deployment impact evaluation
- Go/no-go recommendations

---

## Creating New Use Cases

Each use case follows this structure:
```
use-cases/your-use-case/
├── README.md              # Use case documentation
├── workflow.yml           # Main workflow file
├── config/
│   ├── template.yml       # Configuration template
│   └── examples/          # Example configurations
└── samples/
    ├── input-example.json # Sample input data
    └── output-example.md  # Sample output report
```

### Getting Started

1. Copy the `backlog-analyzer` directory as a template
2. Modify the workflow to use appropriate core components
3. Update configuration parameters for your scenario
4. Test with sample data
5. Create documentation and examples

For detailed guidance, see the [Framework Development Guide](../docs/FRAMEWORK-DEVELOPMENT.md).