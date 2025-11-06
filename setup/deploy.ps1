# GitHub Copilot + Azure DevOps Backlog Analyzer - Quick Setup
# One command to get everything working!

param(
    [Parameter(Mandatory=$true)]
    [string]$Organization,
    
    [Parameter(Mandatory=$true)]
    [string]$Project,
    
    [Parameter(Mandatory=$true)]
    [string]$GitHubToken
)

Write-Host "🚀 Setting up GitHub Copilot Backlog Analyzer..." -ForegroundColor Green
Write-Host ""

# Validate Azure DevOps CLI is installed
Write-Host "🔍 Checking prerequisites..."
try {
    $null = az devops --version
    Write-Host "✅ Azure DevOps CLI found" -ForegroundColor Green
} catch {
    Write-Host "❌ Azure DevOps CLI not found" -ForegroundColor Red
    Write-Host "📥 Install it here: https://docs.microsoft.com/en-us/azure/devops/cli/" -ForegroundColor Yellow
    exit 1
}

# Set Azure DevOps defaults
Write-Host "📋 Configuring Azure DevOps..."
az devops configure --defaults organization=https://dev.azure.com/$Organization project=$Project

# Create variable group for GitHub token
Write-Host "🔐 Setting up credentials..."
$variableGroupExists = az pipelines variable-group list --query "[?name=='copilot-credentials']" --output tsv 2>$null
if (-not $variableGroupExists) {
    $null = az pipelines variable-group create --name "copilot-credentials" --variables GITHUB_TOKEN=$GitHubToken
    Write-Host "✅ Created variable group 'copilot-credentials'" -ForegroundColor Green
} else {
    Write-Host "ℹ️ Variable group 'copilot-credentials' already exists" -ForegroundColor Yellow
    Write-Host "💡 You may need to update the GITHUB_TOKEN manually" -ForegroundColor Yellow
}

# Create the pipeline
Write-Host "📥 Creating pipeline..."
$pipelineName = "Copilot-Backlog-Analyzer"
try {
    $null = az pipelines create --name $pipelineName --yml-path "backlog-analyzer.yml" --repository . --repository-type tfsgit
    Write-Host "✅ Pipeline '$pipelineName' created successfully" -ForegroundColor Green
} catch {
    Write-Host "ℹ️ Pipeline may already exist or there was an issue creating it" -ForegroundColor Yellow
    Write-Host "💡 You can manually import 'backlog-analyzer.yml' in Azure DevOps" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "🎉 Setup Complete!" -ForegroundColor Green
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Cyan
Write-Host "1. Go to: https://dev.azure.com/$Organization/$Project/_build"
Write-Host "2. Find your '$pipelineName' pipeline"
Write-Host "3. Click 'Run Pipeline'"
Write-Host "4. Set 'projectName' to '$Project' (or your actual project name)"
Write-Host "5. Click 'Run' and watch the AI analyze your backlog!"
Write-Host ""
Write-Host "💡 Tip: Start with 5-10 work items for your first run" -ForegroundColor Yellow