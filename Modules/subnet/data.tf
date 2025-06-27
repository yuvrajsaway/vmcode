data "azurerm_resource_group" "resource_group" {
  name = var.resource_group_name
}

data "azurerm_virtual_network" "vnet_name" {
  name                = var.vnet_name
  resource_group_name = data.azurerm_resource_group.resource_group.name
}

