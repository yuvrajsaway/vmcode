resource "azurerm_network_security_group" "nsg" {
  name                = var.nsg_name
  location            = data.azurerm_resource_group.resource_group.location
  resource_group_name = var.resource_group_name
  
  
  security_rule {
    name                       = "test123"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

 
}

resource "azurerm_subnet_network_security_group_association" "frontend_assoc" {
  depends_on = [ azurerm_network_security_group.nsg ]
  subnet_id                 = data.azurerm_subnet.frontend_subnet.id
  network_security_group_id = data.azurerm_network_security_group.nsg.id
}
