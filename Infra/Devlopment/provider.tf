terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.34.0"
    }
   }
  
}

provider "azurerm" {
  # Configuration options
  features {}
  subscription_id = "d471b3fd-4ab5-4021-bbbb-3f55ab2e7a83"
}



