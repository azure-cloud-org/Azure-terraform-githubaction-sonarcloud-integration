/*
##Basic TF code configuration with sonarcloud integration
#Sonarcloud detects the security issues during pipeline run but deployment gets complete/wont failed
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

# Create Subnet
resource "azurerm_subnet" "mysubnet-sonarcloud" {
  name                 = "mysubnet-snyk-integration"
  resource_group_name  = azurerm_resource_group.myrg-sonarcloud-2.name
  virtual_network_name = azurerm_virtual_network.myvnet-sonarcloud-2.name
  address_prefixes     = ["10.2.0.0/27"]
}


##creating allow all inbound firewall rule to verify sonarcloud SAST detection
resource "azurerm_network_security_group" "example-sonarcloud" {
  name                = "example-nsg"
  location            = azurerm_resource_group.myrg-sonarcloud-2.location
  resource_group_name = azurerm_resource_group.myrg-sonarcloud-2.name

  security_rule {
    name                       = "test123"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "example-sonarcloud" {
  subnet_id                 = azurerm_subnet.mysubnet-sonarcloud.id
  network_security_group_id = azurerm_network_security_group.example-sonarcloud.id
}

##Storage account creation--with allow public access
resource "azurerm_storage_account" "example-sonarcloud" {
  name                     = "sonarcloudsa"
  resource_group_name      = azurerm_resource_group.myrg-sonarcloud-2.name
  location                 = azurerm_resource_group.myrg-sonarcloud-2.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "prod"
  }
}
*/

##The resources tested as part of sonarcloud scan quality gate failed then fail the TF apply
##if sonarcloud quality gate check fails>>fails the TF apply
# Create a resource group
resource "azurerm_resource_group" "myrg-sonar-quality-gate" {
  name = "myrg-sonarcloud-quality-gate"
  location = "East US"
}

# Create Virtual Network
# Create Virtual Network
# Create Virtual Network
resource "azurerm_virtual_network" "myvnet-sonarcloud-quality-gate" {
  name                = "myvnet-sonarcloud-quality-gate"
  address_space       = ["10.1.0.0/24"]
  location            = azurerm_resource_group.myrg-sonar-quality-gate.location
  resource_group_name = azurerm_resource_group.myrg-sonar-quality-gate.name
}

# Create Subnet
resource "azurerm_subnet" "mysubnet-sonarcloud-quality-gate" {
  name                 = "mysubnet-sonarcloud-quality-gate"
  resource_group_name  = azurerm_resource_group.mmyrg-sonar-quality-gate.name
  virtual_network_name = azurerm_virtual_network.myvnet-sonarcloud-quality-gate.name
  address_prefixes     = ["10.1.0.0/27"]
}

##creating allow all inbound firewall rule to verify sonarcloud SAST detection
resource "azurerm_network_security_group" "sonarcloud-quality-gate" {
  name                = "example-nsg-quality-gate"
  location            = azurerm_resource_group.myrg-sonar-quality-gate.location
  resource_group_name = azurerm_resource_group.myrg-sonar-quality-gate.name

  security_rule {
    name                       = "test123-quality-gate"
    priority                   = 102
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "sonarcloud-quality-gate" {
  subnet_id                 = azurerm_subnet.mysubnet-sonarcloud-quality-gate.id
  network_security_group_id = azurerm_network_security_group.sonarcloud-quality-gate.id
}
