module "resource_group" {
  source = "../../Modules/Resource_group"

  resource_group_name = "yuvrajrg001"
  location            = "east us"
}

module "azurerm_virtual_network" {
  depends_on = [module.resource_group]
  source     = "../../Modules/Vnet"

  vnet_name           = "yuvivnet001"
  resource_group_name = "yuvrajrg001"
  address_space       = ["192.168.0.0/22"]
  dns_servers         = ["192.168.0.4", "192.168.0.5"]
}

module "frontend_subnet" {
  depends_on          = [module.azurerm_virtual_network]
  source              = "../../Modules/subnet"
  subnet_name         = "frontendsubnet"
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

module "network_interface_frontend" {
  depends_on          = [module.frontend_subnet]
  source              = "../../Modules/nic"
  nic                 = "frontendnic"
  subnet_name         = "frontendsubnet"
  vnet_name           = "yuvivnet001"
  resource_group_name = "yuvrajrg001"

}

module "network_interface_backend" {
  depends_on          = [module.backend_subnet]
  source              = "../../Modules/nic"
  nic                 = "backendnic"
  subnet_name         = "backendsubnet"
  vnet_name           = "yuvivnet001"
  resource_group_name = "yuvrajrg001"

}

module "virtual_machine_frontend" {
  depends_on = [module.network_interface_frontend]
  source     = "../../Modules/virtual_machine"

  virtual_machine_name = "frontend_machine"
  resource_group_name  = "yuvrajrg001"
  location             = "east us"
  network_interface_ids = module.network_interface_frontend.id


}

module "virtual_machine_backend" {
  depends_on = [module.network_interface_backend]
  source     = "../../Modules/virtual_machine"

  virtual_machine_name = "backend_machine"
  resource_group_name  = "yuvrajrg001"
  location             = "east us"
  network_interface_ids = module.network_interface_backend.id


}




