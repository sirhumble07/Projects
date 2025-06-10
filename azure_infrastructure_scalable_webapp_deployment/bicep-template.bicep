// Azure Scalable Web App Deployment - Bicep Template
// Refined for modularity, security, and automation

param resourceGroupName string = 'WebAppRG'
param location string = 'eastus'
param vnetName string = 'WebAppVNet'
param appSubnetName string = 'AppSubnet'
param dbSubnetName string = 'DbSubnet'
param storageAccountName string = 'webappstorage'
param sqlServerName string = 'webapp-sqlserver'
param sqlDbName string = 'webappdb'
param adminUser string = 'sqladmin'
param adminPassword string
param appServiceName string = 'WebAppService'
param monitoringWorkspaceName string = 'WebAppMonitor'

resource resourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: resourceGroupName
  location: location
}

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2021-02-01' = {
  name: vnetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: ['10.1.0.0/16']
    }
    subnets: [
      {
        name: appSubnetName
        properties: {
          addressPrefix: '10.1.1.0/24'
        }
      }
      {
        name: dbSubnetName
        properties: {
          addressPrefix: '10.1.2.0/24'
        }
      }
    ]
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

resource sqlServer 'Microsoft.Sql/servers@2022-05-01' = {
  name: sqlServerName
  location: location
  properties: {
    administratorLogin: adminUser
    administratorLoginPassword: adminPassword
  }
}

resource sqlDatabase 'Microsoft.Sql/servers/databases@2022-05-01' = {
  parent: sqlServer
  name: sqlDbName
  properties: {
    collation: 'SQL_Latin1_General_CP1_CI_AS'
    maxSizeBytes: 2147483648
  }
}

resource appServicePlan 'Microsoft.Web/serverfarms@2021-02-01' = {
  name: '${appServiceName}-plan'
  location: location
  properties: {
    reserved: false
  }
  sku: {
    name: 'P1v2'
    tier: 'PremiumV2'
  }
}

resource appService 'Microsoft.Web/sites@2021-02-01' = {
  name: appServiceName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
  }
}

resource monitoringWorkspace 'Microsoft.OperationalInsights/workspaces@2021-02-01' = {
  name: monitoringWorkspaceName
  location: location
}

output resourceGroupId string = resourceGroup.id
output vnetId string = virtualNetwork.id
output storageAccountId string = storageAccount.id
output sqlDatabaseId string = sqlDatabase.id
output appServiceId string = appService.id
output monitoringWorkspaceId string = monitoringWorkspace.id
