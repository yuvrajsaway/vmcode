module "resource_group" {
  source = "../../Modules/Resource_group"

  resource_group_name = "yuvrajrg001"
  location            = "west us"
}

module "key_vault" {
  depends_on          = [module.resource_group]
  source              = "../../Modules/key_vault"
  keyvault            = "keyvault01"
  resource_group_name = "yuvrajrg001"
}

module "key_secret01" {
  depends_on            = [module.key_vault]
  source                = "../../Modules/keyvault_secrets"
  secret_username       = "vmusername"
  secret_username_value = "admin001"
  secret_password       = "vmpassword"
  secret_password_value = "password1234"
  resource_group_name   = "yuvrajrg001"
  keyvault              = "keyvault01"

}

# module "key_secret02" {
#   depends_on          = [module.key_vault]
#   source              = "../../Modules/keyvault_secrets"
#   secret_password =          = "password"
#   secret_password_value = "password1234"
#   resource_group_name = "yuvrajrg001"
#   keyvault            = "keyvault01"

# }

module "azurerm_public_ip" {
  depends_on = [module.resource_group]
  source     = "../../Modules/public_ip"

  azurerm_public_ip   = "publicip001"
  resource_group_name = "yuvrajrg001"
}

module "azurerm_virtual_network" {
  depends_on = [module.resource_group]
  source     = "../../Modules/Vnet"

  vnet_name           = "yuvivnet001"
  resource_group_name = "yuvrajrg001"
  address_space       = ["192.168.0.0/22"]
  dns_servers         = ["192.168.0.4", "192.168.0.5"]

}



module "azurerm_network_security_group" {
  depends_on          = [module.resource_group, module.frontend_subnet]
  source              = "../../Modules/nsg"
  nsg_name            = "nsg001"
  resource_group_name = "yuvrajrg001"
  subnet_id           = module.frontend_subnet.subnet_id

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
  depends_on          = [module.frontend_subnet, module.azurerm_public_ip]
  source              = "../../Modules/nic"
  nic                 = "frontendnic"
  subnet_name         = "frontendsubnet"
  vnet_name           = "yuvivnet001"
  resource_group_name = "yuvrajrg001"
  azurerm_public_ip   = module.azurerm_public_ip.id
}

module "network_interface_backend" {
  depends_on          = [module.backend_subnet]
  source              = "../../Modules/nic"
  nic                 = "backendnic"
  subnet_name         = "backendsubnet"
  vnet_name           = "yuvivnet001"
  resource_group_name = "yuvrajrg001"
  azurerm_public_ip   = null

}





module "virtual_machine_frontend" {
  depends_on = [module.network_interface_frontend, module.key_secret01]
  source     = "../../Modules/virtual_machine"

  virtual_machine_name  = "frontendmachine"
  resource_group_name   = "yuvrajrg001"
  # username              = "admin001"
  # password              = "P@$$w0rd#123"
  network_interface_ids = [module.network_interface_frontend.id]
  keyvault = "keyvault01"


}

module "virtual_machine_backend" {
  depends_on = [module.network_interface_backend, ]
  source     = "../../Modules/virtual_machine"

  virtual_machine_name  = "backendmachine"
  resource_group_name   = "yuvrajrg001"
  # username              = "admin001"
  # password              = "P@$$w0rd#123"
  network_interface_ids = [module.network_interface_backend.id]
  keyvault = "keyvault01"


}


module "mssql" {
  depends_on = [module.resource_group]
  source     = "../../Modules/mssql_server"

  mssql_name          = "mssqldbserver"
  resource_group_name = "yuvrajrg001"
}

module "database" {
  depends_on = [module.mssql]
  source     = "../../Modules/mssql_database"

  db_name   = "tododb"
  server_id = module.mssql.id
}

