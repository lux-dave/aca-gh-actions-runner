param location string
param project string
param tags {
  *: string
}
param enablePurgeProtection bool = false

var uniqueSuffix = uniqueString(subscription().id, location, project)

resource kv 'Microsoft.KeyVault/vaults@2022-07-01' = {
  location: location
  name: take('kv-${project}-${uniqueSuffix}', 24)
  tags: tags
  properties: {
    enablePurgeProtection: enablePurgeProtection ? true : null
    enableRbacAuthorization: true
    enabledForTemplateDeployment: true
    sku:{
      name: 'standard'
      family: 'A'
    }
    tenantId: tenant().tenantId
  }
  resource kvGhAppKey 'secrets' = {
    name: 'github-app-key'
    properties: {
      value: ''
    }
  }
}



output kvName string = kv.name
