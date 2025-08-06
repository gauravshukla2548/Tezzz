terraform {
  required_providers {
     azurerm={
         source = "hashicorp/azurerm"
          version = "4.37.0"

}

  }

terraform {
  backend "azurerm" {
     resource_group_name      = "shikha"
    storage_account_name = "storageaccountname"                                 # Can be passed via `-backend-config=`"storage_account_name=<storage account name>"` in the `init` command.
    container_name       = "gaurav"                                  # Can be passed via `-backend-config=`"container_name=<container name>"` in the `init` command.
    key                  = "new.tfstate"                   # Can be passed via `-backend-config=`"key=<blob key name>"` in the `init` command.
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

resource "azurerm_storage_account" "example-1" {
  depends_on = [ azurerm_resource_group.rg_name ]
  name                     = "storageaccountname"
  resource_group_name      = "shikha"
  location                 = "Eastus"
  account_tier             = "Standard"
  account_replication_type = "GRS"
}


