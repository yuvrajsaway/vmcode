data "azurerm_resource_group" "resource_group" {
  name = var.resource_group_name
}

data "azurerm_client_config" "current" {}

# data "azurerm_key_vault" "keyvault" {
#   name                = var.keyvault
#   resource_group_name = var.resource_group_name
# }