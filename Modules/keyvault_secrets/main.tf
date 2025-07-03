resource "azurerm_key_vault_secret" "username" {
  name         = var.secret_username
  value        = var.secret_username_value
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

resource "azurerm_key_vault_secret" "password" {
  name         = var.secret_password
  value        = var.secret_password_value
  key_vault_id = data.azurerm_key_vault.keyvault.id
}