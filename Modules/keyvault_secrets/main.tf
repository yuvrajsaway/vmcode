resource "azurerm_key_vault_secret" "secret" {
  name         = "username"
  value        = var.secret_value
  key_vault_id = var.key_vault_id
}

