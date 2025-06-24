

resource "azurerm_subnet" "subnet_name" {
  name                 = var.subnet_name
  resource_group_name  = data.azurerm_resource_group.resource_group.name
  virtual_network_name = data.azurerm_virtual_network.vnet_name.name
  address_prefixes     = var.address_prefixes
}