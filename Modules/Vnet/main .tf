resource "azurerm_virtual_network" "vnet_name" {
  name                = var.vnet_name
  location            = data.azurerm_resource_group.resource_group.location
  resource_group_name = data.azurerm_resource_group.resource_group.name
  address_space       = var.address_space
  dns_servers         = var.dns_servers

}

