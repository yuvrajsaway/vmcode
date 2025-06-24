terraform {
  

backend "azurerm" {
    resource_group_name  = "yuvrajrg001"
    storage_account_name = "yuvistorage001"
    container_name       = "yuvitfstate"
    key                  = "yuviterraform.tfstate"
    # access_key           = "your-storage-account-access-key"
  }
}