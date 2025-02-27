param location string
param project string
param tags {
  *: string
}
@minLength(3)
@maxLength(6)
param suffix string


resource acr 'Microsoft.ContainerRegistry/registries@2023-07-01' = {
  name: 'acr${uniqueString(project, suffix)}'
  location: location
  tags: tags
  sku: {
    name: 'Basic'
  }
}

output acrName string = acr.name
