resource "azurerm_mssql_server" "mssqlsrvr" {
  name                         = var.mssql_name
  resource_group_name          = data.azurerm_resource_group.resource_group.name
  location                     = data.azurerm_resource_group.resource_group.location
  version                      = "12.0"
  administrator_login          = "mssqladmin"
  administrator_login_password = "P@$$w0rd@123"
}

output "id" {
  value = azurerm_mssql_server.mssqlsrvr.id
}