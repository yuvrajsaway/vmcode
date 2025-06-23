module "resource_group" {
  source = "../../Modules/Resource_group"

  resource_group_name = "yuvrajrg001"
  location            = "east us"
}

module "azurerm_virtual_network" {
  depends_on = [module.resource_group]
  source     = "../../Modules/Vnet"

  vnet_name           = "yuvivnet001"
  location            = "east us"
  resource_group_name = "yuvrajrg001"
  address_space       = ["192.168.0.0/22"]
  dns_servers         = ["192.168.0.4", "192.168.0.5"]
}

module "frontend_subnet" {
  depends_on          = [module.azurerm_virtual_network]
  source              = "../../Modules/subnet"
  subnet_name         = "frontsubnet"
  resource_group_name = "yuvrajrg001"
  vnet_name           = "yuvivnet001"
  address_prefixes    = ["192.168.1.0/24"]
}

module "backend_subnet" {
  depends_on          = [module.azurerm_virtual_network]
  source              = "../../Modules/subnet"
  subnet_name         = "backendsubnet"
  resource_group_name = "yuvrajrg001"
  vnet_name           = "yuvivnet001"
  address_prefixes    = ["192.168.2.0/24"]
}

module "network_interface_forntend" {
  depends_on          = [module.frontend_subnet]
  source              = "../../Modules/nic"
  nic                 = "frontendnic"
  location            = "east us"
  resource_group_name = "yuvrajrg001"
  subnet_id           = module.frontend_subnet.subnet_id
}

module "network_interface_backend" {
  depends_on          = [module.backend_subnet]
  source              = "../../Modules/nic"
  nic                 = "backendnic"
  location            = "east us"
  resource_group_name = "yuvrajrg001"
  subnet_id           = module.backend_subnet.subnet_id
}

module "virtual_machine_forntend" {
  depends_on = [module.network_interface_forntend]
  source     = "../../Modules/virtual_machine"

  virtual_machine_name = "frontend_machine"
  resource_group_name  = "yuvrajrg001"
  location             = "east us"


}

module "virtual_machine_backend" {
  depends_on = [module.network_interface_backend]
  source     = "../../Modules/virtual_machine"

  virtual_machine_name = "backend_machine"
  resource_group_name = "yuvrajrg001"
  location             = "east us"


}




