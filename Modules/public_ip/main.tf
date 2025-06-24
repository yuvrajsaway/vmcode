
resource "azurerm_public_ip" "public_ip" {
  name                = var.azurerm_public_ip
  resource_group_name = data.azurerm_resource_group.resource_group.name
  location            = data.azurerm_resource_group.resource_group.location
  allocation_method   = "Static"
}


