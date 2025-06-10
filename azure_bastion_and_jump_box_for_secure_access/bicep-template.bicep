// Azure Bastion & Jump Box - Bicep Template
// Refined for modularity, security, and scalability

param resourceGroupName string = 'SecureAccessRG'
param location string = 'eastus'
param vnetName string = 'SecureVNet'
param subnetName string = 'PrivateSubnet'
param bastionSubnetName string = 'AzureBastionSubnet'
param vmName string = 'JumpBoxVM'
param bastionName string = 'AzureBastion'
param adminUsername string = 'adminUser'
param vmSize string = 'Standard_B2s'
param vmImage string = 'MicrosoftWindowsServer:WindowsServer:2019-Datacenter:latest'

resource resourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: resourceGroupName
  location: location
}

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2021-02-01' = {
  name: vnetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: ['10.0.0.0/16']
    }
    subnets: [
      {
        name: subnetName
        properties: {
          addressPrefix: '10.0.1.0/24'
        }
      }
      {
        name: bastionSubnetName
        properties: {
          addressPrefix: '10.0.2.0/24'
        }
      }
    ]
  }
}

resource virtualMachine 'Microsoft.Compute/virtualMachines@2021-07-01' = {
  name: vmName
  location: location
  properties: {
    hardwareProfile: {
      vmSize: vmSize
    }
    storageProfile: {
      imageReference: {
        publisher: split(vmImage, ':')[0]
        offer: split(vmImage, ':')[1]
        sku: split(vmImage, ':')[2]
        version: split(vmImage, ':')[3]
      }
    }
    osProfile: {
      computerName: vmName
      adminUsername: adminUsername
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: virtualNetwork.properties.subnets[0].id
        }
      ]
    }
  }
}

resource bastionHost 'Microsoft.Network/bastionHosts@2021-02-01' = {
  name: bastionName
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'BastionIPConfig'
        properties: {
          subnet: {
            id: virtualNetwork.properties.subnets[1].id
          }
        }
      }
    ]
  }
}

output vnetId string = virtualNetwork.id
output vmId string = virtualMachine.id
output bastionId string = bastionHost.id
