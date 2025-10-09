param managedDiskName string = 'az104-disk5'
param location string = 'eastus'
param diskSizeInGiB int = 32
param skuName string = 'StandardSSD_LRS'

resource disk 'Microsoft.Compute/disks@2021-04-01' = {
  name: managedDiskName
  location: location
  sku: {
    name: skuName
  }
  properties: {
    creationData: {
      createOption: 'Empty'
    }
    diskSizeGB: diskSizeInGiB
  }
}

output diskId string = disk.id