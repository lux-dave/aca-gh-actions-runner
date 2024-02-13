param location string
param project string
param tags {
  *: string
}
param tenantId string

var uniqueSuffix = uniqueString(subscription().id, location, project)

resource kv 'Microsoft.KeyVault/vaults@2022-07-01' = {
  location: location
  name: 'kv-${project}-${uniqueSuffix}'
  tags: tags
  properties: {
    enablePurgeProtection:false
    enableRbacAuthorization: true
    sku:{
      name: 'standard'
      family: 'A'
    }
    tenantId: tenantId
  }
}

output kvName string = kv.name
