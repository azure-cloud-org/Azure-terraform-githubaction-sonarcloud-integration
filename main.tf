# Create a resource group
resource "azurerm_resource_group" "myrg-sonarcloud" {
  name = "myrg-sonarcloud-integration"
  location = "East US"
}

# Create Virtual Network
resource "azurerm_virtual_network" "myvnet-sonarcloud" {
  name                = "myvnet-sonarcloud-integration-demo"
  address_space       = ["10.1.0.0/24"]
  location            = azurerm_resource_group.myrg-sonarcloud.location
  resource_group_name = azurerm_resource_group.myrg-sonarcloud.name
}

# Create Subnet
resource "azurerm_subnet" "mysubnet-sonarcloud" {
  name                 = "mysubnet-sonarcloud-integration"
  resource_group_name  = azurerm_resource_group.myrg-sonarcloud.name
  virtual_network_name = azurerm_virtual_network.myvnet-sonarcloud.name
  address_prefixes     = ["10.1.0.0/27"]
}