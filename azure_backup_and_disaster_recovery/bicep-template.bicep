// Azure Backup and Disaster Recovery - Bicep Template
// Refined for modularity, security, and scalability

param resourceGroupName string = 'BackupRG'
param location string = 'eastus'
param vaultName string = 'RecoveryVault'
param storageType string = 'GeoRedundant'
param backupPolicyName string = 'DailyBackupPolicy'
param vmName string = 'CriticalVM'
param vmResourceId string

resource recoveryVault 'Microsoft.RecoveryServices/vaults@2023-01-01' = {
  name: vaultName
  location: location
  properties: {
    storageType: storageType
  }
}

resource backupPolicy 'Microsoft.RecoveryServices/vaults/backupPolicies@2023-01-01' = {
  parent: recoveryVault
  name: backupPolicyName
  properties: {
    schedulePolicy: {
      scheduleRunFrequency: 'Daily'
      scheduleRunTimes: [
        '2023-01-01T02:00:00Z'
      ]
    }
    retentionPolicy: {
      dailySchedule: {
        retentionDuration: {
          count: 30
          durationType: 'Days'
        }
      }
    }
  }
}

resource backupProtection 'Microsoft.RecoveryServices/vaults/backupFabrics/protectionContainers/protectedItems@2023-01-01' = {
  parent: recoveryVault
  name: '${vmName}-Backup'
  properties: {
    protectedItemType: 'AzureIaaSVMProtectedItem'
    sourceResourceId: vmResourceId
    policyId: backupPolicy.id
  }
}

resource siteRecovery 'Microsoft.RecoveryServices/vaults/replicationFabrics@2023-01-01' = {
  parent: recoveryVault
  name: 'AzureFabric'
  properties: {}
}

resource replicationPolicy 'Microsoft.RecoveryServices/vaults/replicationPolicies@2023-01-01' = {
  parent: recoveryVault
  name: 'ReplicationPolicy'
  properties: {
    replicationFrequencyInSeconds: 300
    recoveryPointRetentionInHours: 24
    applicationConsistentSnapshotFrequencyInHours: 4
  }
}

resource failoverVM 'Microsoft.RecoveryServices/vaults/replicationFabrics/replicationProtectionContainers/replicationProtectedItems@2023-01-01' = {
  parent: siteRecovery
  name: '${vmName}-Failover'
  properties: {
    sourceResourceId: vmResourceId
    policyId: replicationPolicy.id
  }
}

output vaultId string = recoveryVault.id
output backupPolicyId string = backupPolicy.id
output replicationPolicyId string = replicationPolicy.id
