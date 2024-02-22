param location string
param project string
param tags {
  *: string
}
param suffix string


resource acr 'Microsoft.ContainerRegistry/registries@2023-07-01' = {
  name: 'acr${replace(project, '-', '')}${replace(suffix, '-', '')}'
  location: location
  tags: tags
  sku: {
    name: 'Basic'
  }
}

output acrName string = acr.name
