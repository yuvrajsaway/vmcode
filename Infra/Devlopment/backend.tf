terraform {


  backend "azurerm" {
    resource_group_name  = "DoNotDeleteGroup"
    storage_account_name = "11donotdeletestorage1111"
    container_name       = "tfstate"
    key                  = "yuviterraform.tfstate"
    # access_key           = "your-storage-account-access-key"
  }
}