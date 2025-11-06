# GitHub Copilot + Azure DevOps Backlog Analyzer - Credential Setup
# Sets up the required variable group with GitHub token

param(
    [Parameter(Mandatory=$true)]
    [string]$Organization,
    
    [Parameter(Mandatory=$true)]
    [string]$Project,
    
    [Parameter(Mandatory=$true)]
    [string]$GitHubToken
)

Write-Host "🔐 Setting up GitHub Copilot credentials..." -ForegroundColor Green
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
    Write-Host "💡 Updating GitHub token..." -ForegroundColor Yellow
    $groupId = az pipelines variable-group list --query "[?name=='copilot-credentials'].id" --output tsv
    $null = az pipelines variable-group variable update --group-id $groupId --name GITHUB_TOKEN --value $GitHubToken
    Write-Host "✅ Updated GitHub token in existing variable group" -ForegroundColor Green
}

Write-Host ""
Write-Host "✅ Credentials Setup Complete!" -ForegroundColor Green
Write-Host ""
Write-Host "🎯 Next Steps:" -ForegroundColor Cyan
Write-Host "1. Go to: https://dev.azure.com/$Organization/$Project/_build"
Write-Host "2. Click 'New Pipeline'"
Write-Host "3. Choose your source (Azure Repos Git, GitHub, etc.)"
Write-Host "4. Select 'Existing Azure Pipelines YAML file'"
Write-Host "5. Choose 'backlog-analyzer.yml'"
Write-Host "6. Save & Run the pipeline"
Write-Host ""
Write-Host "⚙️ Pipeline Parameters:" -ForegroundColor Yellow
Write-Host "- Project Name: '$Project'"
Write-Host "- Work Items: Start with 5-10 for testing"
Write-Host "- Analysis Mode: 'standard'"
Write-Host ""
Write-Host "🔗 Direct link: https://dev.azure.com/$Organization/$Project/_build" -ForegroundColor Cyan
