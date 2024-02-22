param location string
param project string
param tags {
  *: string
}
param enablePurgeProtection bool = false
param suffix string


resource kv 'Microsoft.KeyVault/vaults@2022-07-01' = {
  location: location
  name: take('kv-${project}-${suffix}', 24)
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
