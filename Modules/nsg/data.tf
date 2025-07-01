data "azurerm_resource_group" "resource_group" {
  name = var.resource_group_name
}

# data "azurerm_network_security_group" "nsg" {
#   name                = "nsg001"
#   resource_group_name = "yuvrajrg001"
# }

data "azurerm_subnet" "frontend_subnet" {
  name                 = "frontendsubnet"
  virtual_network_name = "yuvivnet001"
  resource_group_name  = "yuvrajrg001"
}
