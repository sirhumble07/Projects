// WordPress on Azure with High Availability - Bicep Template
// Refined for automation, security, and performance optimization

param resourceGroupName string = 'WordPressRG'
param location string = 'eastus'
param appServicePlanName string = 'WordPressAppServicePlan'
param webAppName string = 'WordPressWebApp'
param databaseServerName string = 'WordPressDBServer'
param databaseName string = 'WordPressDB'
param adminUsername string = 'dbadmin'
param adminPassword string
param storageAccountName string = 'wordpressstorage'
param cdnProfileName string = 'WordPressCDN'
param cdnEndpointName string = 'WordPressCDNEndpoint'
param monitorWorkspaceName string = 'WordPressMonitor'

// Create Resource Group
resource resourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: resourceGroupName
  location: location
}

// Deploy App Service Plan for WordPress
resource appServicePlan 'Microsoft.Web/serverfarms@2021-03-01' = {
  name: appServicePlanName
  location: location
  properties: {
    reserved: false
  }
  sku: {
    name: 'P2v2'
    tier: 'PremiumV2'
  }
}

// Deploy Web App for WordPress
resource webApp 'Microsoft.Web/sites@2021-03-01' = {
  name: webAppName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
  }
}

// Deploy Azure Database for MySQL
resource databaseServer 'Microsoft.DBforMySQL/servers@2021-06-01' = {
  name: databaseServerName
  location: location
  properties: {
    administratorLogin: adminUsername
    administratorLoginPassword: adminPassword
    sslEnforcement: 'Enabled'
  }
}

resource database 'Microsoft.DBforMySQL/servers/databases@2021-06-01' = {
  parent: databaseServer
  name: databaseName
  properties: {
    charset: 'utf8mb4'
    collation: 'utf8mb4_general_ci'
  }
}

// Deploy Azure Storage for Static Content
resource storageAccount 'Microsoft.Storage/storageAccounts@2021-08-01' = {
  name: storageAccountName
  location: location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
}

// Deploy Azure CDN for Faster Content Delivery
resource cdnProfile 'Microsoft.Cdn/profiles@2021-06-01' = {
  name: cdnProfileName
  location: location
  sku: {
    name: 'Standard_Microsoft'
  }
}

resource cdnEndpoint 'Microsoft.Cdn/profiles/endpoints@2021-06-01' = {
  parent: cdnProfile
  name: cdnEndpointName
  properties: {
    origins: [
      {
        name: 'StorageOrigin'
        properties: {
          hostName: storageAccount.properties.primaryEndpoints.web
        }
      }
    ]
  }
}

// Set up Azure Monitor and Logging
resource monitorWorkspace 'Microsoft.OperationalInsights/workspaces@2021-03-01' = {
  name: monitorWorkspaceName
  location: location
}

output resourceGroupId string = resourceGroup.id
output appServicePlanId string = appServicePlan.id
output webAppId string = webApp.id
output databaseServerId string = databaseServer.id
output databaseId string = database.id
output storageAccountId string = storageAccount.id
output cdnProfileId string = cdnProfile.id
output monitorWorkspaceId string = monitorWorkspace.id
