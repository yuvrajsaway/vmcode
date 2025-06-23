
resource "azurerm_public_ip" "example" {
  name                = var.azurerm_public_ip
  resource_group_name = var.azurerm_resource_group
  location            = var.location
  allocation_method   = "Static"
}