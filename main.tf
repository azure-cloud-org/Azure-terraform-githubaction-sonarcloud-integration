/*
# Create a resource group
resource "azurerm_resource_group" "myrg-sonarcloud" {
  name = "myrg-sonarcloud-integration"
  location = "East US"
}

# Create Virtual Network
# Create Virtual Network
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
*/

##configured Clear text password to check/verify whether sonarcloud detect this config issue or not??
##azure MSSQL Server

resource "azurerm_mssql_server" "example" {
  name                         = "example-sqlserver"
  resource_group_name          = azurerm_resource_group.myrg-sonarcloud-2.name
  location                     = azurerm_resource_group.myrg-sonarcloud-2.location
  version                      = "12.0"
  administrator_login          = "admin32156"
  administrator_login_password = "F0rtigate@123"
  tags = {
    env = "Dev"
    env = "prod"
    owner = "vivek"
  }
}


# Create a resource group
resource "azurerm_resource_group" "myrg-sonarcloud-2" {
  name = "myrg-sonarcloud-integration-2"
  location = "East US"
  tags = {
    env = "Dev"
    env = "prod"
    owner = "vivek"
  }
}

##Repeated commented lines to verify configured sonarcloud quality gate rule
# Create Virtual Network
resource "azurerm_virtual_network" "myvnet-sonarcloud-2" {
  name                = "myvnet-sonarcloud-integration-demo-2"
  address_space       = ["10.2.0.0/24"]
  location            = azurerm_resource_group.myrg-sonarcloud-2.location
  resource_group_name = azurerm_resource_group.myrg-sonarcloud-2.name
  tags = {
    env = "Dev"
    env = "prod"
    owner = "vivek"
  }
}