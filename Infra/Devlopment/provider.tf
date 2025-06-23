terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.34.0"
    }
   }
   backend "azurerm" {
    resource_group_name  = "yuvrajrg001"
    storage_account_name = "yuvistorage001"
    container_name       = "yuvitfstate"
    key                  = "yuviterraform.tfstate"
    # access_key           = "your-storage-account-access-key"
  }
}

provider "azurerm" {
  # Configuration options
  features {}
  subscription_id = "d471b3fd-4ab5-4021-bbbb-3f55ab2e7a83"
}