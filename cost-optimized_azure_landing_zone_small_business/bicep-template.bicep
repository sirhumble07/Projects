// Cost-Optimized Azure Landing Zone - Bicep Template
// Refined for governance, scalability, and automation

param resourceGroupName string = 'LandingZoneRG'
param location string = 'eastus'
param managementGroupName string = 'SmallBusinessMG'
param subscriptionId string
param budgetName string = 'LandingZoneBudget'
param policyName string = 'CompliancePolicy'
param storageAccountName string = 'smallbusinessstorage'
param adminUser string = 'landingzoneadmin'
param taggingPolicyName string = 'TaggingPolicy'

resource resourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: resourceGroupName
  location: location
}

resource managementGroup 'Microsoft.Management/managementGroups@2021-04-01' = {
  name: managementGroupName
}

resource budget 'Microsoft.Consumption/budgets@2021-10-01' = {
  name: budgetName
  location: location
  properties: {
    amount: 5000
    timeGrain: 'Monthly'
    category: 'Cost'
    notifications: [
      {
        enabled: true
        threshold: 80
        contactEmails: ['admin@smallbusiness.com']
      }
    ]
  }
}

resource policyAssignment 'Microsoft.PolicyInsights/policyAssignments@2021-06-01' = {
  name: policyName
  location: location
  properties: {
    policyDefinitionId: '/providers/Microsoft.Management/managementGroups/${managementGroupName}/providers/Microsoft.PolicyInsights/policyDefinitions/${policyName}'
    scope: '/subscriptions/${subscriptionId}'
  }
}

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-08-01' = {
  name: storageAccountName
  location: location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
}

resource taggingPolicy 'Microsoft.PolicyInsights/policyAssignments@2021-06-01' = {
  name: taggingPolicyName
  location: location
  properties: {
    policyDefinitionId: '/providers/Microsoft.Management/managementGroups/${managementGroupName}/providers/Microsoft.PolicyInsights/policyDefinitions/${taggingPolicyName}'
    scope: '/subscriptions/${subscriptionId}'
  }
}

output resourceGroupId string = resourceGroup.id
output managementGroupId string = managementGroup.id
output budgetId string = budget.id
output policyAssignmentId string = policyAssignment.id
output storageAccountId string = storageAccount.id
output taggingPolicyId string = taggingPolicy.id
