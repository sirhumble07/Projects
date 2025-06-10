// Azure Sentinel SIEM Setup - Bicep Template
// Refined for modularity, security, and automation

param resourceGroupName string = 'SecurityRG'
param location string = 'eastus'
param logAnalyticsWorkspaceName string = 'SentinelWorkspace'
param sentinelName string = 'AzureSentinel'
param playbookName string = 'SentinelPlaybook'

resource resourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: resourceGroupName
  location: location
}

resource logAnalyticsWorkspace 'Microsoft.OperationalInsights/workspaces@2021-03-01' = {
  name: logAnalyticsWorkspaceName
  location: location
  properties: {}
}

resource sentinel 'Microsoft.SecurityInsights/alertRules@2021-09-01-preview' = {
  parent: logAnalyticsWorkspace
  name: sentinelName
  properties: {
    displayName: 'High-Severity Threat Detection'
    description: 'Detect potential security threats across Azure resources'
    severity: 'High'
    queryFrequency: 'PT5M'
    queryPeriod: 'PT15M'
  }
}

resource playbook 'Microsoft.Logic/workflows@2019-05-01' = {
  name: playbookName
  location: location
  properties: {
    state: 'Enabled'
    definition: {
      "$schema": "https://schema.management.azure.com/providers/Microsoft.Logic/schemas/2016-06-01/workflowDefinition.json",
      "actions": {
        "SendAlert": {
          "inputs": {
            "method": "POST",
            "uri": "https://security-alerts.example.com",
            "body": {
              "alertType": "SentinelAlert",
              "severity": "High"
            }
          }
        }
      }
    }
  }
}

output resourceGroupId string = resourceGroup.id
output logAnalyticsWorkspaceId string = logAnalyticsWorkspace.id
output sentinelId string = sentinel.id
output playbookId string = playbook.id
