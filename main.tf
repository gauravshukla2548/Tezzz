terraform {
  required_providers {
     azurerm={
         source = "hashicorp/azurerm"
          version = "4.37.0"

}

  }
}


provider "azurerm" {
  features {}
  subscription_id = "3f7c4872-f198-45b7-984d-0ab188b016e6"

}


resource "azurerm_resource_group" "rg_name" {
    name= "Shikha"
    location="Eastus"
  
}

resource "azurerm_virtual_network" "vnet_name" {
  name                = "ShikhaVnet"
  address_space       = ["10.0.0.16/16"]
  resource_group_name = "shikha"
  location            = "eastus"
  
}

resource "azurerm_subnet" "subnet_name" {
  name                 = "ShikhaSubnet"
  resource_group_name  = "shikha"
  virtual_network_name = "ShikhaVnet"
  address_prefixes     = ["10.0.0.0/24"]

}

resource "azurerm_network_interface" "nic_name" {
  name                = "ShikhaNIC"
  location            = azurerm_resource_group.rg_name.location
  resource_group_name = azurerm_resource_group.rg_name.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet_name.id
    private_ip_address_allocation = "Dynamic"
  }
}
