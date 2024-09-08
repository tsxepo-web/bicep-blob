resource storacc 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: 'tsxepostorage'
  location: resourceGroup().location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
}

resource ManPolicy 'Microsoft.Storage/storageAccounts/managementPolicies@2023-05-01' = { 
  name: 'default'
  parent: storacc
  properties: {
    policy: { 
      rules: [
        {
          enabled: true
          name: 'move-to-cool'
          type: 'Lifecycle'
          definition: { 
            actions: {
              version: {
                delete: {
                  daysAfterCreationGreaterThan: 90
                }
              }
              baseBlob: {
                tierToCool: { 
                  daysAfterModificationGreaterThan: 30
                }
                tierToArchive: {
                  daysAfterModificationGreaterThan: 90
                  daysAfterLastTierChangeGreaterThan: 7
                }
                delete: {
                  daysAfterModificationGreaterThan: 2555
                }
              }
            }
            filters: {
              blobTypes: [
                'blockBlob'
              ]
              prefixMatch: [
                'sample-container/log'
              ]
            }
          }
        }
      ]
    }
  }
}
