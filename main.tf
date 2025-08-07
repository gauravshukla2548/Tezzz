terraform {
  required_providers {
     azurerm={
         source = "hashicorp/azurerm"
          version = "4.37.0"

 backend "azurerm" {
    storage_account_name = "backend"
    container_name       = "tfstatefile"
    key                  = "new.tfstate"
   
  }


  }

resource "azurerm_resource_group" "shiva" {
  name     = "shiva-rg"
  location = "australia east"
}


resource "azurerm_storage_account" "shivastg" {
  depends_on = [ azurerm_resource_group.shiva ]
  name                     = "shivastgaccount"
  resource_group_name      = "shiva-rg"
  location                 = "australia east"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}


}


