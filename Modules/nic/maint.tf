resource "azurerm_network_interface" "nic" {
  name                = var.nic
  location            = data.azurerm_resource_group.resource_group.location
  resource_group_name = data.azurerm_resource_group.resource_group.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.subnet_name.id
    private_ip_address_allocation = "Dynamic"
    # 👇 Conditionally assign public_ip_address_id
    public_ip_address_id = var.azurerm_public_ip #!= null ? var.azurerm_public_ip : null
  }
}

output "id" {
  value = azurerm_network_interface.nic.id
}