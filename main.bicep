resource storacc 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: 'tsxepostorage'
  location: resourceGroup().location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
}
