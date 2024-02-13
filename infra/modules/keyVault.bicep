param location string
param project string
param tags {
  *: string
}
param tenantId string
param enablePurgeProtection bool = false

var uniqueSuffix = uniqueString(subscription().id, location, project)

resource kv 'Microsoft.KeyVault/vaults@2022-07-01' = {
  location: location
  name: take('kv-${project}-${uniqueSuffix}', 24)
  tags: tags
  properties: {
    enablePurgeProtection: enablePurgeProtection ? true : null
    enableRbacAuthorization: true
    sku:{
      name: 'standard'
      family: 'A'
    }
    tenantId: tenantId
  }
}

output kvName string = kv.name
