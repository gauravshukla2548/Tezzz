terraform {
  required_providers {
     azurerm={
         source = "hashicorp/azurerm"
          version = "4.37.0"

}

  }

 backend "azurerm" {
    resource_group_name  = "ga_rg"
    storage_account_name = "backendga"
    container_name       = "tfstatefile"
    key                  = "new"
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
  name                = "Shikhanic"
  location            = azurerm_resource_group.rg_name.location
  resource_group_name = azurerm_resource_group.rg_name.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet_name.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_public_ip" "pub-ip_name" {
  name                = "ShikhaPublicIP"
  location            = azurerm_resource_group.rg_name.location
  resource_group_name = azurerm_resource_group.rg_name.name
  allocation_method   = "Dynamic"
  
}

resource "azurerm_linux_virtual_machine" "vm_name" {
  name                = "ShikhaVM"
  resource_group_name = azurerm_resource_group.rg_name.name
  location            = azurerm_resource_group.rg_name.location
  size                = "Standard_B1s"
  admin_username      = "adminuser"
  admin_password      = "P@ssw0rd1234!"
  disable_password_authentication = false
  
  network_interface_ids = [
    azurerm_network_interface.nic_name.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
}
