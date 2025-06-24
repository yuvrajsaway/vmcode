resource "azurerm_mssql_database" "database" {
  name         = var.db_name
  server_id    = var.server_id
  
  }

  