param location string
param project string
param tags {
  *: string
}
@maxLength(6)
param suffix string
@secure()
param ghPrivateKey string

module acr '../modules/containerRegistry.bicep' = {
  name: 'deploy-${project}-acr'
  params: {
    location: location
    project: project
    tags: union(tags, { module: 'containerRegistry.bicep' })
    suffix: suffix
  }
}

module kv '../modules/keyVault.bicep' = {
  name: 'deploy-${project}-kv'
  params:{
    location:location
    project:project
    tags: union(tags, { module: 'keyVault.bicep' })
    suffix: suffix
    ghPrivateKey: ghPrivateKey
  }
}

module law '../modules/logAnalytics.bicep' = {
  name: 'deploy-${project}-law'
  params: {
    location: location
    project: project
    tags: union(tags, { module: 'logAnalytics.bicep' })
    suffix: suffix
  }
}

module acaEnv '../modules/containerAppEnvironment.bicep' = {
  name: 'deploy-${project}-aca-env'
  params: {
    location: location
    project: project
    tags: union(tags, { module: 'containerAppEnvironment.bicep' })
    lawName: law.outputs.lawName
    suffix: suffix
  }
}

output acrName string = acr.outputs.acrName
output acaEnvName string = acaEnv.outputs.acaEnvName
output kvName string = kv.outputs.kvName
